//
//  LXFAttentionController.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFAttentionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initEnable()
        self.initUI()
    }
}

extension LXFAttentionController {
    func initUI() {
        self.title = "动态"
        
        let tipView = LXFAttentionTipLoginView.loadFromNib()
        self.view.addSubview(tipView)
        
        tipView.snp.makeConstraints { (make) in
            make.height.equalTo(LXFAttentionTipLoginView.viewHeight())
            make.width.centerX.centerY.equalToSuperview()
        }
        tipView.loginCommand.subscribe(onNext: { () in
            LXFLog("登录")
        }).disposed(by: rx.disposeBag)
    }
}

// MARK:- 初始化协议
extension LXFAttentionController: LXFSwitchTabBarItemable, LXFNavAvatarable {
    func initEnable() {
        self.initSwitchTabBarItemable()
        self.avatar()
    }
}
