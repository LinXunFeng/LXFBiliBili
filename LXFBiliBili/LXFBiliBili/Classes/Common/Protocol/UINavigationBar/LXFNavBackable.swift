//
//  LXFNavBackable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol LXFNavBackable {
    
}

extension LXFNavBackable where Self : UIViewController {
    func back(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "ic_game"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        item.rx.tap.do(onNext: {
            onNext()
        }).subscribe().disposed(by: rx.disposeBag)
        
        navigationItem.leftBarButtonItem = item
    }
}
