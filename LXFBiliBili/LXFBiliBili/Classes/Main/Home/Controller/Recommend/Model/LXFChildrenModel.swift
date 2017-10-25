//
//  LXFChildrenModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFChildrenModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    var id: Int = 0
    var name: String?
}
