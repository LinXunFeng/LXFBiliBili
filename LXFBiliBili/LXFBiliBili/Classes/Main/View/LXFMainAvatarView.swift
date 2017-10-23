//
//  LXFMainAvatarView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXFMainAvatarView: UIView, LXFNibloadable {
    
    @IBOutlet fileprivate weak var drawBtn: UIButton!
    @IBOutlet fileprivate weak var avatarBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension Reactive where Base: LXFMainAvatarView {
    var showMenu: ControlEvent<Void> {
        return ControlEvent(events: Observable.of(self.base.drawBtn.rx.tap, self.base.avatarBtn.rx.tap).merge())
    }
}
