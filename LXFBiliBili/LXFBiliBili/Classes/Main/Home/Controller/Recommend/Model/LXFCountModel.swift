//
//  LXFCountModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFCountModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        atten <- map["atten"]
    }
    
    var atten: Int = 0
}
