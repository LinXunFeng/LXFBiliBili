//
//  LXFOwnerModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFOwnerModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        face <- map["face"]
        mid <- map["mid"]
        name <- map["name"]
    }
    
    var face = ""
    var mid = -1
    var name = ""
}
