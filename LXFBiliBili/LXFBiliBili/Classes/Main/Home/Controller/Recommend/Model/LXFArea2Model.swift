//
//  LXFArea2Model.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFArea2Model: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        children <- map["children"]
    }
    
    var id: Int = 0
    var name: String?
    var children: LXFChildrenModel?
}
