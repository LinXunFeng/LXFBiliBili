//
//  LXFMenuModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import RxDataSources

struct LXFMenuModel {
    var imageName = ""
    var title = ""
}

/* ============================= SectionModel =============================== */

struct LXFMenuSection {
    var items: [Item]
}

extension LXFMenuSection: SectionModelType {
    typealias Item = LXFMenuModel
    
    init(original: LXFMenuSection, items: [Item]) {
        self = original
        self.items = items
    }
}
