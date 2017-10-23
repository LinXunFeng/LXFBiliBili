//
//  LXFIconModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFIconModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        src <- map["src"]
        height <- map["height"]
        width <- map["width"]
    }
    
    var src = ""
    var height = ""
    var width = ""
}
