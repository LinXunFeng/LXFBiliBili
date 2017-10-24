//
//  LXFHomeRecAdCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeRecAdCell: UICollectionViewCell, LXFHomeRecBaseCellable {
    
    var baseView : LXFHomeRecCellTopView!
    
    let adLabel = UILabel().then {
        $0.text = "广告"
        $0.backgroundColor = UIColor.hexColor(0xCCCCCC)
        $0.textAlignment = .center
        $0.textColor = UIColor.white
        $0.font = UIFont.systemFont(ofSize: 12)
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

extension LXFHomeRecAdCell {
    private func initUI() {
        baseView.addSubview(adLabel)
        adLabel.snp.makeConstraints { (make) in
            make.width.equalTo(29)
            make.height.equalTo(18)
            make.left.equalTo(baseView.titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
