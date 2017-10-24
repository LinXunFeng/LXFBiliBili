//
//  LXFBannerItemModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFBannerItemModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cm_mark <- map["cm_mark"]
        hash <- map["hash"]
        server_type <- map["server_type"]
        id <- map["id"]
        resource_id <- map["resource_id"]
        title <- map["title"]
        image <- map["image"]
        request_id <- map["request_id"]
        uri <- map["uri"]
        index <- map["index"]
    }
    
    
    var cm_mark: Int = 0
    var hash: String?
    var server_type: Int = 0
    var id: Int = 0
    var resource_id: Int = 0
    var title: String?
    var image: String?
    var request_id: String?
    var uri: String?
    var index: Int = 0
}
