//
//  LXFRcmdreasonModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFRcmdreasonModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        bg_color <- map["bg_color"]
        content <- map["content"]
        icon_location <- map["icon_location"]
        id <- map["id"]
    }
    
    var bg_color: String?
    var content: String?
    var icon_location: String?
    var id: String?
}

