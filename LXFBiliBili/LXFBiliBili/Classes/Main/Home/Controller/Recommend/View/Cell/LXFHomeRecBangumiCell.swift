//
//  LXFHomeRecBangumiCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeRecBangumiCell: LXFHomeRecArticleCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        borderLabel.text = "番剧"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
