//
//  LXFLiveViewModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import RxAlamofire
import SwiftyJSON
import RxDataSources

class LXFLiveViewModel: NSObject {
    private let vmDatas = Variable<[([LXFBannerModel]?, LXFPartitionModel?, LXFLiveModel?, [LXFLiveModel])]>( [])
}

extension LXFLiveViewModel: LXFViewModelType {
    
    typealias Input = LXFLiveInput
    typealias Output = LXFLiveOutput
    
    struct LXFLiveInput {
    }
    
    struct LXFLiveOutput: OutputRefreshProtocol {
        var refreshStatus: Variable<LXFRefreshStatus>
        
        let sections: Driver<[LXFLiveSection]>
        let requestCommand = PublishSubject<Void>()
        
        init(sections: Driver<[LXFLiveSection]>) {
            self.sections = sections
            refreshStatus = Variable<LXFRefreshStatus>(.none)
        }
    }
    
    func transform(input: LXFLiveViewModel.LXFLiveInput) -> LXFLiveViewModel.LXFLiveOutput {
        let temp_sections = vmDatas.asObservable().map({ (sections) -> [LXFLiveSection] in
            return sections.map({ (banner, nomalHeader, bannerDataHeader, models) -> LXFLiveSection in
                return LXFLiveSection(banner: banner, normalHeader: nomalHeader, BannerDataHeader: bannerDataHeader, items: models)
            })
        }).asDriver(onErrorJustReturn: [])
        
        let output = LXFLiveOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: {[weak self] () in
            guard let `self` = self else { return }
            let request = json(.get, kUrlGetAllList)
            // 监听网络
            request.asObservable().subscribe({ (event) in
                switch event {
                case let .error(error):
                    LXFLog(error)
                case .next, .completed:
                    break
                }
                output.refreshStatus.value = .endHeaderRefresh
            }).disposed(by: self.rx.disposeBag)
            // 获取数据
            request.lxf_json({
                return JSON($0)["data"]
            }).mapObject(LXFHomeLiveModel.self).subscribe(onNext: { (datas) in
                var sectionArr: [([LXFBannerModel]?, LXFPartitionModel?, LXFLiveModel?, [LXFLiveModel])] = []
                
                var bannerArr: [[LXFBannerModel]] = []
                var headerArr: [LXFPartitionModel] = []
                var bannerDataArr: [LXFLiveModel] = []
                var cellArr: [[LXFLiveModel]] = []
                
                guard let recommend_data = datas.recommend_data else { return }
                guard let partitions = datas.partitions else { return }
                
                // banner
                bannerArr.append(datas.banner!)
                
                // 前12个
                let recommend_lives = recommend_data.lives!
                let midpoint = recommend_lives.count / 2
                let cell1 = Array(recommend_lives[0..<midpoint])
                let cell2 = Array(recommend_lives[midpoint...])
                
                cellArr.append(cell1)
                cellArr.append(cell2)
                cellArr = cellArr + partitions.enumerated().map({ (index, element) -> [LXFLiveModel] in
                    return element.lives!
                })
                
                // normalHeaders
                headerArr.append(recommend_data.partition!)
                headerArr.append(recommend_data.partition!)
                _ = partitions.map({
                    headerArr.append($0.partition!)
                })
                
                // BannnerDataHeader
                bannerDataArr.append(recommend_data.banner_data!.last!)
                bannerDataArr.append(recommend_data.banner_data!.last!)
                
                for i in 0..<cellArr.count {
                    sectionArr.append((bannerArr[i~], headerArr[i], bannerDataArr[i~], cellArr[i]))
                }
                
                // 更新数据
                self.vmDatas.value = sectionArr
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}


/* ============================= 自定义section =============================== */

struct LXFLiveSection {
    var banner: [LXFBannerModel]?
    var normalHeader: LXFPartitionModel?
    var BannerDataHeader : LXFLiveModel?
    var items: [Item]
}

extension LXFLiveSection: SectionModelType {
    typealias Item = LXFLiveModel
    
    init(original: LXFLiveSection, items: [LXFLiveModel]) {
        self = original
        self.items = items
    }
}
