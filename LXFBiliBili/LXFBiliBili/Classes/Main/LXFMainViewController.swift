//
//  LXFMainViewController.swift
//  LXFBiliBili
//
//  Created by xiaozikeji on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import Then

class LXFMainViewController: UITabBarController {
    
    lazy var interative: Bool = {
        return false
    }()
    lazy var lastIndex: Int = {
        return -1
    }()
    lazy var interactionController: UIPercentDrivenInteractiveTransition = {
        return UIPercentDrivenInteractiveTransition()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // 初始化子控制器
        self.initSubViewControllers()
        
        // 设置tabBarItem选中与未选中的文字颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeGrayColor], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemePinkColor], for: UIControlState.selected)
        
        self.tabBar.tintColor = kThemePinkColor
        self.tabBar.backgroundColor = UIColor.white
        
        
        let menuView = LXFMenuView()
        self.view.addSubview(menuView)
    }
}

extension LXFMainViewController {
    func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        let translationX = panGesture.translation(in: self.view).x
        let translationAbs = abs(translationX)
        var progress = translationAbs / self.view.frame.size.width
        
        var beganTime: TimeInterval = 0
        
        switch panGesture.state {
        case .began:
            beganTime = CACurrentMediaTime()
            self.interative = true
            self.lastIndex = self.selectedIndex
            if translationX < 0 {
                self.selectedIndex += 1;
            } else {
                self.selectedIndex -= 1;
            }
        case .changed:
            if self.lastIndex > self.selectedIndex && translationX < 0 || self.lastIndex < self.selectedIndex && translationX > 0 {
                progress = 0
            }
            self.interactionController.update(progress)
        case .cancelled, .ended:
            let speed = translationAbs / CGFloat(CACurrentMediaTime() - beganTime)
            self.interactionController.completionSpeed = 0.99
            if progress > 0.5 || speed > 600 {
                self.interactionController.finish()
            } else {
                self.interactionController.cancel()
            }
            self.interative = false
            self.lastIndex = -1
        case .possible, .failed:
            break
        }
    }
}


extension LXFMainViewController {
    private func initSubViewControllers() {
        
        let classNameArr = ["Home", "Category", "Attention", "Message"]
        let moduleNameArr = ["首页", "分区", "动态", "消息"]
        var tabArr: [UIViewController] = []
        let projectName = self.getProjectName()
        
        for i in 0..<classNameArr.count {
            
            let clsName = classNameArr[i]
            let moduleName = moduleNameArr[i]
            let lowStr = clsName.lowercased()
            
            let clsType = NSClassFromString(projectName+"LXF"+clsName+"Controller") as! UIViewController.Type
            let vc = clsType.init()
            
            let item: UITabBarItem = UITabBarItem(title: moduleName, image: UIImage(named: "home_"+lowStr+"_tab"), selectedImage: UIImage(named: "home_"+lowStr+"_tab_s"))
            item.titlePositionAdjustment = UIOffsetMake(0, -5)
            vc.tabBarItem = item
            vc.view.backgroundColor = UIColor.white
            let navVc = LXFBaseNavigationController(rootViewController: vc)
            tabArr.append(navVc)
        }
        self.viewControllers = tabArr
    }
    
    func getProjectName() -> String {
        guard let infoDict = Bundle.main.infoDictionary else {
            return "."
        }
        let key = kCFBundleExecutableKey as String
        guard let value = infoDict[key] as? String else {
            return "."
        }
        return value + "."
    }
}


// MARK:- UITabBarControllerDelegate
extension LXFMainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let fromIndex: Int = (tabBarController.viewControllers ?? []).index(of: fromVC) ?? 0
        let toIndex: Int = (tabBarController.viewControllers ?? []).index(of: toVC) ?? 0
        
        let direction : LXFTabOperationDirection  = toIndex < fromIndex ? .left : .right
        return LXFTabBarControllerAnimatedTransitioning(direction)
    }
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interative ? self.interactionController : nil
    }
}
