//
//  LXFNibloadable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

protocol LXFNibloadable {
    
}

extension LXFNibloadable {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
}
