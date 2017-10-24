//
//  LXFTagModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFTagModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        count <- map["count"]
        tag_name <- map["tag_name"]
        tag_id <- map["tag_id"]
    }
    
    var count: LXFCountModel?
    var tag_name: String?
    var tag_id: Int = 0
}
