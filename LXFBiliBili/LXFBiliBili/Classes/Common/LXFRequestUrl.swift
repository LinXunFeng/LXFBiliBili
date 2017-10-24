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
let liveUri = "http://api.live.bilibili.com/"
// 检查状态
let kUrlLiveCheck = liveUri + "assistant/LiveCheck?_device=android&_hwid=Pwc3BzUCOllgWW9eIl4i&appkey=1d8b6e7d45233436&build=515000&mobi_app=android&mobile=genymotion_vbox86p_5.1_151117_200001&platform=android&src=kuan&system=22&trace_id=20171019034900026&ts=1508399366&version=5.15.0.515000&sign=76f47a440a1ff4164faf41fc596f3ca4"

// 分类
let kUrlGetAreas = liveUri + "room/v1/AppIndex/getAreas?_device=android&_hwid=Pwc3BzUCOllgWW9eIl4i&appkey=1d8b6e7d45233436&build=515000&device=android&mobi_app=android&platform=android&scale=xhdpi&src=kuan&trace_id=20171019034900026&ts=1508399366&version=5.15.0.515000&sign=8fe2091c7683c86721da54690ab9fdbf"

// 实际数据
let kUrlGetAllList = liveUri + "room/v1/AppIndex/getAllList?_device=android&_hwid=Pwc3BzUCOllgWW9eIl4i&appkey=1d8b6e7d45233436&build=515000&device=android&mobi_app=android&platform=android&scale=xhdpi&src=kuan&trace_id=20171019034900026&ts=1508399366&version=5.15.0.515000&sign=8fe2091c7683c86721da54690ab9fdbf"

// MARK: 推荐
let recommendUri = "http://app.bilibili.com/"
// 实际数据(刷新、分页)
// https://app.bilibili.com/x/feed/index?appkey=1d8b6e7d45233436&build=515000&idx=1508565029&login_event=0&pull=true

/*
url中有几个参数需要注意：
idx：第一次加载数据时为0（此时，open_event=cold），若是加载更多，则是之前数据中的最后一个idx，或是刷新，则是之前数据中一开始的idx。
pull：刷新为true，加载更多为false。
ts：不明（不用也无所谓）。
login_event：为1时会加载banner，为0时则不加载banner(细节有待考究)

条目布局有2大类（注意goto的值）：
大布局（各个布局都不一样）：
轮播(banner)、横副（ad、话题）、全站排行榜（rank）、小埋广告（converge）、标签（tag）
小布局（布局都差不多）：
普通视频（av）、分类（bangumi）、登录（login）、广告（ad_web_s）、文章（article_s）
tip：建议只做小布局和大布局中的前2个。
*/

let kUrlFeed = recommendUri + "x/feed/index?appkey=1d8b6e7d45233436&build=515000"

