//
//  LXFSwitchTabBarItemable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

protocol LXFSwitchTabBarItemable {
    
}

extension LXFSwitchTabBarItemable where Self : UIViewController {
    func initSwitchTabBarItemable() {
        view.rx.panGesture().subscribe(onNext: {
            guard let mainVc = self.tabBarController as? LXFMainViewController else { return }
            mainVc.handlePanGesture($0)
        }).disposed(by: rx.disposeBag)
    }
}
