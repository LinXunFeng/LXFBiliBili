//
//  LXFHomeLiveModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper

struct LXFHomeLiveModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        banner <- map["banner"]
        entranceIcons <- map["entranceIcons"]
        partitions <- map["partitions"]
        recommend_data <- map["recommend_data"]
    }
    
    var banner : [LXFBannerModel]?
    var entranceIcons : [LXFEntranceIconModel]?
    var partitions : [LXFPartitionsModel]?
    var recommend_data: LXFRecommendDataModel?
}


