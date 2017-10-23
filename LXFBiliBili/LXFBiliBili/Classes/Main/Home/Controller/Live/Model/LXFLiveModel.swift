//
//  LXFLiveModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct LXFLiveModel:  Mappable{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        roomid <- map["roomid"]
        uid <- map["uid"]
        title <- map["title"]
        uname <- map["uname"]
        online <- map["online"]
        user_cover <- map["user_cover"]
        user_cover_flag <- map["user_cover_flag"]
        system_cover <- map["system_cover"]
        link <- map["link"]
        cover_size <- map["cover_size"]
        parent_id <- map["parent_id"]
        parent_name <- map["parent_name"]
        area_id <- map["area_id"]
        area_name <- map["area_name"]
        play_url <- map["play_url"]
        accept_quality <- map["accept_quality"]
        broadcast_type <- map["broadcast_type"]
        is_tv <- map["is_tv"]
        corner <- map["corner"]
        
        owner <- map["owner"]
        cover <- map["cover"]
        check_version <- map["check_version"]
        area <- map["area"]
        area_v2_id <- map["area_v2_id"]
        area_v2_name <- map["area_v2_name"]
        area_v2_parent_id <- map["area_v2_parent_id"]
        area_v2_parent_name <- map["area_v2_parent_name"]
    }
    
    var roomid = -1
    var uid = -1
    var title = ""
    var uname = ""
    var online = -1
    var user_cover = ""
    var user_cover_flag = -1
    var system_cover = ""
    var link = ""
    var cover_size : LXFIconModel?
    var parent_id = -1
    var parent_name = ""
    var area_id = -1
    var area_name = ""
    var play_url = ""
    var accept_quality = ""
    var broadcast_type = -1
    var is_tv = -1
    var corner = ""
    
    var owner : LXFOwnerModel?
    var cover : LXFIconModel?
    var check_version = -1
    var area = ""
    var area_v2_id = -1
    var area_v2_name = ""
    var area_v2_parent_id = -1
    var area_v2_parent_name = ""
}


