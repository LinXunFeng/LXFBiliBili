//
//  LXFHomeRecLoginCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class LXFHomeRecLoginCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rx.tapGesture().skip(1).subscribe(onNext: { (_) in
            LXFLog("登录")
        }).disposed(by: rx.disposeBag)
    }

}
