//
//  LXFMessageTipView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/20.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class LXFMessageTipView: UIView, LXFNibloadable {
    
    let loginCommand = PublishSubject<Void>()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rx.tapGesture().subscribe(onNext: { (_) in
            self.loginCommand.asObserver().onNext(())
        }).disposed(by: rx.disposeBag)
    }
    
    

}

extension LXFMessageTipView: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 138.0
    }
}
