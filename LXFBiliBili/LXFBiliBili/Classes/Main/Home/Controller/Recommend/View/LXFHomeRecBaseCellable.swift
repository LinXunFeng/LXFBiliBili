//
//  LXFHomeRecBaseCellable.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

protocol LXFHomeRecBaseCellable {
    var baseView : LXFHomeRecCellTopView! {get}
}

extension LXFHomeRecBaseCellable where Self : UICollectionViewCell {
    func initBaseView() -> LXFHomeRecCellTopView {
        let baseView = LXFHomeRecCellTopView.loadFromNib()
        self.addSubview(baseView)
        baseView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return baseView
    }
}
