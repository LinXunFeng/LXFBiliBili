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
    private let models = Variable<[LXFHomeRecommendModel]>([])
}

extension LXFRecommendViewModel: LXFViewModelType {
    typealias Input = LXFRecommendInput
    typealias Output = LXFRecommendOutput
    
    
    struct LXFRecommendInput {
        
    }
    
    struct LXFRecommendOutput: OutputRefreshProtocol {
        var refreshStatus: Variable<LXFRefreshStatus>
        
        let requestCommand = PublishSubject<Void>()
        let sections : Driver<[LXFRecommendSection]>
        
        init(sections: Driver<[LXFRecommendSection]>) {
            self.sections = sections
            refreshStatus = Variable<LXFRefreshStatus>(.none)
        }
    }
    
    func transform(input: LXFRecommendViewModel.Input) -> LXFRecommendViewModel.Output {
        let temp_sections = models.asObservable().map { (temp_models) -> [LXFRecommendSection] in
            return [LXFRecommendSection(items: temp_models)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = LXFRecommendOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: {[weak self] () in
            guard let `self` = self else { return }
            // idx=1508565029&login_event=0&pull=true
            let parameters = ["idx": "1508565029","login_event":"0", "pull":"true"]
            let request = json(.get, kUrlFeed, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            request.lxf_json({
                return JSON($0)["data"]
            }).mapArray(LXFHomeRecommendModel.self).subscribe(onNext: { (datas) in
                self.models.value = datas
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}

/* ============================= 自定义section =============================== */

struct LXFRecommendSection {
    var items: [Item]
    
}

extension LXFRecommendSection: SectionModelType {
    typealias Item = LXFHomeRecommendModel
    
    init(original: LXFRecommendSection, items: [LXFHomeRecommendModel]) {
        self = original
        self.items = items
    }
}

