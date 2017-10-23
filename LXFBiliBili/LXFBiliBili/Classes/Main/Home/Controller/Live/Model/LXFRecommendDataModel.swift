//
//  LXFRecommendDataModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct LXFRecommendDataModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        partition <- map["partition"]
        lives <- map["lives"]
        banner_data <- map["banner_data"]
    }
    
    var partition : LXFPartitionModel?
    var lives : [LXFLiveModel]?
    var banner_data : [LXFLiveModel]?
}


struct LXFRecommendDataSection {
    var items: [Item]
}

extension LXFRecommendDataSection: SectionModelType {
    typealias Item = LXFRecommendDataModel
    
    init(original: LXFRecommendDataSection, items: [LXFRecommendDataModel]) {
        self = original
        self.items = items
    }
}

