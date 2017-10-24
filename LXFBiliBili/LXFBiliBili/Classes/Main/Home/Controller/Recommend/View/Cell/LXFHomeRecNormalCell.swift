//
//  LXFHomeRecNormalCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeRecNormalCell: UICollectionViewCell, LXFHomeRecBaseCellable {
    var baseView: LXFHomeRecCellTopView!
    
    let categoryLabel = UILabel().then {
        $0.text = "LinXunFeng"
        $0.textColor = UIColor.hexColor(0xCCCCCC)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        baseView = initBaseView()
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LXFHomeRecNormalCell {
    private func initUI() {
        baseView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(baseView.titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(baseView.moreBtn.snp.top)
            make.right.equalTo(baseView.moreBtn.snp.left)
        }
    }
}
