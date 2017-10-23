//
//  LXFMessageController.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class LXFMessageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initEnable()
        self.initUI()
    }
}

extension LXFMessageController {
    private func initUI() {
        self.title = "消息"
        
        let tipView = LXFMessageTipView.loadFromNib()
        self.view.addSubview(tipView)
        
        tipView.snp.makeConstraints { (make) in
            make.height.equalTo(LXFMessageTipView.viewHeight())
            make.width.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        tipView.loginCommand.subscribe(onNext: { () in
            LXFLog("登录")
        }).disposed(by: rx.disposeBag)
    }
}

// MARK:- 初始化协议
extension LXFMessageController: LXFSwitchTabBarItemable, LXFNavAvatarable {
    func initEnable() {
        self.initSwitchTabBarItemable()
        self.avatar()
    }
}
