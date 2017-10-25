//
//  LXFBaseNavigationController.swift
//  LXFBiliBili
//
//  Created by xiaozikeji on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFBaseNavigationController: UINavigationController, LXFNavBackable {
    
    private var popGesture: UIGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏样式
        navigationBar.setBackgroundImage(UIImage.color(kThemePinkColor), for: UIBarPosition.any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        
        // 标题样式
        let bar = UINavigationBar.appearance()
        bar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
        ]
        
        // 设置返回按钮的样式
        navigationBar.tintColor = UIColor.white     // 设置返回标识器的颜色
        let barItem = UIBarButtonItem.appearance()
        barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)  // 返回按钮文字样式
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
