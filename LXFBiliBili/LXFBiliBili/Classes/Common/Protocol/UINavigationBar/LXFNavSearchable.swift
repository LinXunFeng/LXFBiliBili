//
//  LXFNavSearchable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/18.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol LXFNavSearchable {
    
}

extension LXFNavSearchable where Self : UIViewController {
    func search(onNext: @escaping ()->Void) {
        
        let item = UIBarButtonItem(image: UIImage(named: "ic_search"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        item.rx.tap.do(onNext: {
            onNext()
        }).subscribe().disposed(by: rx.disposeBag)
        
        if (navigationItem.rightBarButtonItems?.count ?? 0) == 0 {
            navigationItem.rightBarButtonItems = [item]
        } else {
            var items: [UIBarButtonItem] = [] + navigationItem.rightBarButtonItems!
            items.append(item)
            navigationItem.rightBarButtonItems = items
        }
    }
}
