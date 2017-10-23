//
//  LXFRequestUrl.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/20.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation

// MARK:- 首页
// MARK: 直播
let originUri = "http://api.live.bilibili.com/"
// 检查状态
let kUrlLiveCheck = originUri + "assistant/LiveCheck?_device=android&_hwid=Pwc3BzUCOllgWW9eIl4i&appkey=1d8b6e7d45233436&build=515000&mobi_app=android&mobile=genymotion_vbox86p_5.1_151117_200001&platform=android&src=kuan&system=22&trace_id=20171019034900026&ts=1508399366&version=5.15.0.515000&sign=76f47a440a1ff4164faf41fc596f3ca4"

// 分类
let kUrlGetAreas = originUri + "room/v1/AppIndex/getAreas?_device=android&_hwid=Pwc3BzUCOllgWW9eIl4i&appkey=1d8b6e7d45233436&build=515000&device=android&mobi_app=android&platform=android&scale=xhdpi&src=kuan&trace_id=20171019034900026&ts=1508399366&version=5.15.0.515000&sign=8fe2091c7683c86721da54690ab9fdbf"

// 实际数据
let kUrlGetAllList = originUri + "room/v1/AppIndex/getAllList?_device=android&_hwid=Pwc3BzUCOllgWW9eIl4i&appkey=1d8b6e7d45233436&build=515000&device=android&mobi_app=android&platform=android&scale=xhdpi&src=kuan&trace_id=20171019034900026&ts=1508399366&version=5.15.0.515000&sign=8fe2091c7683c86721da54690ab9fdbf"
