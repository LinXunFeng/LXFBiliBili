//
//  LXFBannerModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFBannerModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        img <- map["img"]
        remark <- map["remark"]
        link <- map["link"]
        
        cover <- map["cover"]
        is_clip <- map["is_clip"]
    }
    
    var title = ""
    var img = ""
    var remark = ""
    var link = ""
    
    var cover: LXFIconModel?
    var is_clip = 0
}
