//
//  LXFNavAvatarable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/17.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

let kLXFNavAvatarableNote = "LXFNavAvatarable"

protocol LXFNavAvatarable {
    
}

extension LXFNavAvatarable where Self : UIViewController {
    
    func avatar() {
        
        let xib = LXFMainAvatarView.loadFromNib()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: xib)
        // Xcode9 直接添加上去获取不到尺寸
        xib.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        xib.rx.showMenu.subscribe(onNext: { () in
            NotificationCenter.default.post(name: Notification.Name(rawValue: kLXFNavAvatarableNote), object: nil)
        }).disposed(by: rx.disposeBag)
    }
}
