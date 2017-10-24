//
//  LXFDislikeReasonsModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFDislikeReasonsModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        reason_id <- map["reason_id"]
        reason_name <- map["reason_name"]
    }
    
    var reason_id: Int = 0
    var reason_name: String?
}
