//
//  LXFPartitionsModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFPartitionsModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        partition <- map["partition"]
        lives <- map["lives"]
    }
    
    var partition : LXFPartitionModel?
    var lives : [LXFLiveModel]?
}
