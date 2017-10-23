//
//  LXFAttentionTipLoginView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/20.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXFAttentionTipLoginView: UIView, LXFNibloadable {
    @IBOutlet private weak var loginBtn: UIButton!
    
    let loginCommand = PublishSubject<Void>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loginBtn.rx.tap.subscribe(onNext: { () in
            self.loginCommand.asObserver().onNext(())
        }).disposed(by: rx.disposeBag)
    }

    
}

extension LXFAttentionTipLoginView: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 267.0
    }
}
