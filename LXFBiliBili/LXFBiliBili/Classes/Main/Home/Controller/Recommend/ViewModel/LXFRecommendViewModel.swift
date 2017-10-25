//
//  LXFRecommendViewModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import SwiftyJSON
import Alamofire
import RxDataSources

class LXFRecommendViewModel: NSObject {
//    private let models = Variable<[[LXFHomeRecommendModel]]>([])
//    private let headers = Variable<[[LXFHomeRecommendModel]]>([])
    private let vmDatas = Variable<[(LXFHomeRecommendModel?,[LXFHomeRecommendModel])]>( [])
}

extension LXFRecommendViewModel: LXFViewModelType {
    typealias Input = LXFRecommendInput
    typealias Output = LXFRecommendOutput
    
    
    struct LXFRecommendInput {
        
    }
    
    struct LXFRecommendOutput: OutputRefreshProtocol {
        var refreshStatus: Variable<LXFRefreshStatus>
        
        let requestCommand = PublishSubject<Bool>()
        let sections : Driver<[LXFRecommendSection]>
        
        init(sections: Driver<[LXFRecommendSection]>) {
            self.sections = sections
            refreshStatus = Variable<LXFRefreshStatus>(.none)
        }
    }
    
    func transform(input: LXFRecommendViewModel.Input) -> LXFRecommendViewModel.Output {
        let temp_sections = vmDatas.asObservable().map { (sections) -> [LXFRecommendSection] in
            return sections.map({ (header, models) -> LXFRecommendSection in
                return LXFRecommendSection(header: header, items: models)
            })
        }.asDriver(onErrorJustReturn: [])
        
        let output = LXFRecommendOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: {[weak self] (isPull) in
            guard let `self` = self else { return }
            // https://app.bilibili.com/x/feed/index?appkey=1d8b6e7d45233436&build=515000&idx=1508565029&login_event=0&mobi_app=android&network=wifi&open_event=&platform=android&pull=true&style=2&ts=1508565282&sign=7232bbbc81722ccbfd46f4dbe81963be
            // idx=1508565029&login_event=0&pull=true
            var pull = ""
            var idx = "0"
            let xx = self.vmDatas.value
            var login_event = "1" // 第一次需要加载轮播
            if isPull { // 下拉
                pull = "true"
                idx = "\(xx.first?.1.last?.idx ?? 0)"
                login_event = xx.count != 0 ? "0" : "1"
            } else { // 上拉
                pull = "false"
                idx = "\(xx.last?.1.last?.idx ?? 0)"
                login_event = "0"
            }
            let parameters = ["idx": idx,"login_event":login_event, "pull":pull]
            let request = json(.get, kUrlFeed, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            request.subscribe({ (event) in
                switch event {
                case let .error(error):
                    LXFLog(error)
                default:
                    break
                }
                output.refreshStatus.value = .endHeaderRefresh
                output.refreshStatus.value = .endFooterRefresh
            }).disposed(by: self.rx.disposeBag)
            request.lxf_json({
                return JSON($0)["data"]
            }).mapArray(LXFHomeRecommendModel.self).subscribe(onNext: { (datas) in
                // topic special banner converge rank tag
                // av有两种： 带rcmd_reason的为编辑推荐 不带则是普通item
                let sectionGotoArr = ["topic", "special", "banner"] // "converge", "rank", "tag"
                let itemGotoArr = ["login", "ad_web_s", "av", "article_s", "bangumi"]
                
                var sec: LXFHomeRecommendModel?
                var models: [LXFHomeRecommendModel] = []
                var sectionModels: [(LXFHomeRecommendModel?, [LXFHomeRecommendModel])] = []
                
                _ = datas.map({
                    if sectionGotoArr.contains($0.goto ?? "") {
                        if models.count != 0 {
                            sectionModels.append((sec, models))
                        }
                        models = []
                        sec = $0
                    } else if itemGotoArr.contains($0.goto ?? "") {
                        models.append($0)
                    }
                })
                
                if models.count != 0 {
                    sectionModels.append((sec, models))
                }
                
                self.vmDatas.value = isPull ? sectionModels + self.vmDatas.value : self.vmDatas.value + sectionModels
                
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}

/* ============================= 自定义section =============================== */

struct LXFRecommendSection {
    var header: LXFHomeRecommendModel?
    var items: [Item]
}

extension LXFRecommendSection: SectionModelType {
    typealias Item = LXFHomeRecommendModel
    
    init(original: LXFRecommendSection, items: [LXFHomeRecommendModel]) {
        self = original
        self.items = items
    }
}

