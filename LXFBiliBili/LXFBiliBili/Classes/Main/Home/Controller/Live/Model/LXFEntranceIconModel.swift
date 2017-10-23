//
//  LXFEntranceIconModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFEntranceIconModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        entrance_icon <- map["entrance_icon"]
    }
    
    var id = -1
    var name = ""
    var entrance_icon: LXFIconModel?
}
