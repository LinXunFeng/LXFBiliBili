//
//  LXFHomeViewController.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import SnapKit
import Then
import TYPagerController
import RxSwift
import RxCocoa

class LXFHomeController: UIViewController {
    private let titles: [String] = ["直播", "推荐", "追番", "专栏"]
    private let pageVc = TYTabPagerController().then {
        $0.pagerController.scrollView?.backgroundColor = kThemePinkColor
        $0.tabBar.layout.barStyle = .progressElasticView
        $0.tabBar.layout.cellWidth = kScreenW * 0.25
        $0.tabBar.layout.cellSpacing = 0
        $0.tabBar.layout.cellEdging = 0
        $0.tabBar.layout.progressColor = UIColor.white
        $0.tabBar.layout.normalTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        $0.tabBar.layout.selectedTextColor = kThemeBackgroundColor
        $0.tabBar.backgroundColor = kThemePinkColor
    }
    private var vcs: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initPageController()
        self.initEnable()
    }
}
// MARK:- 初始化协议
extension LXFHomeController: LXFNavAvatarable, LXFNavSearchable, LXFNavDownloadable, LXFNavGameable {
    func initEnable() {
        
        self.avatar()
        self.search {
            LXFLog("搜索")
        }
        self.download {
            LXFLog("下载")
        }
        self.game {
            LXFLog("游戏")
        }
    }
}
// MARK:- 初始化Page
private var previousX: CGFloat = 0.0
private var currentX: CGFloat = 0.0
extension LXFHomeController {
    private func initPageController() {
        let scrollView = pageVc.pagerController.scrollView!
        pageVc.delegate = self
        pageVc.dataSource = self
        scrollView.rx.didScroll.subscribe(onNext: { () in
            currentX = scrollView.contentOffset.x
            if currentX > previousX {
                // print(scrollView.contentOffset.x/kScreenW)
                // 右
                if scrollView.contentOffset.x/kScreenW <= 3.0 { return }
                guard let tabBarVc = self.tabBarController as? LXFMainViewController else { return }
                tabBarVc.selectedIndex += 1
            } else {
                // 左
            }
        }).disposed(by: rx.disposeBag)
        pageVc.view.frame = self.view.frame
        view.addSubview(pageVc.view)
        self.addChildViewController(pageVc)
        pageVc.view.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        pageVc.reloadData()
        // 设置起始页
        pageVc.pagerController.scrollToController(at: 1, animate: false)
    }
}


extension LXFHomeController: TYTabPagerControllerDelegate, TYTabPagerControllerDataSource {
    func numberOfControllersInTabPagerController() -> Int {
        return titles.count
    }
    func tabPagerController(_ tabPagerController: TYTabPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        if index == 0 {
            return LXFLiveViewController()
        } else if index == 1 {
            return LXFRecommendController()
        }
        let vc = UIViewController()
        vc.view.backgroundColor = kThemeBackgroundColor
        return vc
    }
    func tabPagerController(_ tabPagerController: TYTabPagerController, titleFor index: Int) -> String {
        return titles[index]
    }
}
