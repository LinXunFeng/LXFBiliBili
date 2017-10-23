//
//  LXFPartitionModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFPartitionModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        sub_icon <- map["sub_icon"]
        count <- map["count"]
        
        area <- map["area"]
    }
    
    var id = -1
    var name = ""
    var sub_icon : LXFIconModel?
    var count = 0
    
    var area = ""
}
