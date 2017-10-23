//
//  LXFNavGameable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol LXFNavGameable {
    
}

extension LXFNavGameable where Self : UIViewController {
    func game(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "ic_game"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        item.rx.tap.do(onNext: {
            onNext()
        }).subscribe().addDisposableTo(rx.disposeBag)
        
        if (navigationItem.rightBarButtonItems?.count ?? 0) == 0 {
            navigationItem.rightBarButtonItems = [item]
        } else {
            var items: [UIBarButtonItem] = [] + navigationItem.rightBarButtonItems!
            items.append(item)
            navigationItem.rightBarButtonItems = items
        }
    }
}

