//
//  LXFPartitionController.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import ReusableKit
import SnapKit
import TYPagerController
import Then

class LXFCategoryController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "分区"
        self.initEnable()
        
    }
}

// MARK:- 初始化协议
extension LXFCategoryController: LXFSwitchTabBarItemable, LXFNavAvatarable, LXFNavSearchable, LXFNavDownloadable {
    func initEnable() {
        self.initSwitchTabBarItemable()
        self.avatar()
        self.search {
            LXFLog("搜索")
        }
        self.download {
            LXFLog("下载")
        }
    }
}
