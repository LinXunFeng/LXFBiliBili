//
//  LXFFlowLayout.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        self.scrollDirection = .vertical
        self.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        let margin = LXFHomeLiveCell.itemMargin()
        let wh = (kScreenW - 3 * margin) * 0.5
        self.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        self.itemSize = CGSize(width: wh, height: wh)
        self.minimumLineSpacing = LXFHomeLiveCell.itemMargin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
