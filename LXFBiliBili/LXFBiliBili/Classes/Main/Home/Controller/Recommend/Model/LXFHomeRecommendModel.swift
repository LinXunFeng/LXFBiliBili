//
//  LXFHomeRecommendModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFHomeRecommendModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        tname <- map["tname"]
        reply <- map["reply"]
        tid <- map["tid"]
        title <- map["title"]
        param <- map["param"]
        ctime <- map["ctime"]
        duration <- map["duration"]
        favorite <- map["favorite"]
        idx <- map["idx"]
        mid <- map["mid"]
        share <- map["share"]
        cover <- map["cover"]
        tag <- map["tag"]
        dislike_reasons <- map["dislike_reasons"]
        uri <- map["uri"]
        name <- map["name"]
        play <- map["play"]
        danmaku <- map["danmaku"]
        coin <- map["coin"]
        goto <- map["goto"]
        face <- map["face"]
        desc <- map["desc"]
        
        area <- map["area"]
        area_id <- map["area_id"]
        area2 <- map["area2"]
        online <- map["online"]
        children <- map["children"]
        rcmd_reason <- map["rcmd_reason"]
        
        hash <- map["hash"]
        banner_item <- map["banner_item"]
    }
    
    var tname: String?
    var reply: Int = 0
    var tid: Int = 0
    var title: String?
    var param: String?
    var ctime: Int = 0
    var duration: Int = 0
    var favorite: Int = 0
    var idx: Int = 0
    var mid: Int = 0
    var share: Int = 0
    var cover: String?
    var tag: LXFTagModel?
    var dislike_reasons: [LXFDislikeReasonsModel]?
    var uri: String?
    var name: String?
    var play: Int = 0
    var danmaku: Int = 0
    var coin: Int = 0
    var goto: String?
    var face: String?
    var desc: String?
    
    var area: String?
    var area_id: Int = 0
    var area2: LXFArea2Model?
    var online: Int = 0
    var children: LXFChildrenModel?
    var rcmd_reason: LXFRcmdreasonModel?
    
    var hash: String?
    var banner_item: [LXFBannerItemModel]?
}



