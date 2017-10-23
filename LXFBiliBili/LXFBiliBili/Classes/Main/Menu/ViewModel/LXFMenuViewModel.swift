//
//  LXFMenuViewModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

class LXFMenuViewModel: NSObject {
    
    let models = Variable<[LXFMenuModel]>([])
}

extension LXFMenuViewModel: LXFViewModelType {
    
    typealias Input = LXFMenuViewInput
    typealias Output = LXFMenuViewOutput
    
    struct LXFMenuViewInput {
        let imageNameArr: [String] = []
        let titleArr: [String] = []
    }
    
    struct LXFMenuViewOutput {
        let sections: Driver<[LXFMenuSection]>
        let requestCommand = PublishSubject<Void>()
    }
    
    func transform(input: LXFMenuViewModel.LXFMenuViewInput) -> LXFMenuViewModel.LXFMenuViewOutput {
        let sections = models.asObservable().map { (models) -> [LXFMenuSection] in
            var sections: [LXFMenuSection] = []
            for model in models {
                sections.append(LXFMenuSection(items: [model]))
            }
            return sections
        }.asDriver(onErrorJustReturn: [])
        
        let output = LXFMenuViewOutput(sections: sections)
        
        output.requestCommand.subscribe(onNext: {
            let imgNameArr = ["home", "history", "offline_cache", "my_collect", "my_follow", "look_later", "live_center", "my_vip", "free_fow", "vip_order"]
            let titleArr = ["首页", "历史记录", "离线缓存", "我的收藏", "我的关注", "稍后再看", "直播中心", "我的大会员", "免流量服务", "会员购订单"]
            var models: [LXFMenuModel] = []
            for i in 0..<imgNameArr.count {
                models.append(LXFMenuModel(imageName: imgNameArr[i], title: titleArr[i]))
            }
            self.models.value = models
        }).disposed(by: rx.disposeBag)
        
        return output
        
    }
    
}

