//
//  LXFHomeRecRecommendCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeRecRecommendCell: UICollectionViewCell, LXFHomeRecBaseCellable {
    
    var baseView: LXFHomeRecCellTopView!
    
    let recLabel = UILabel().then {
        $0.text = "编辑推荐"
        $0.backgroundColor = UIColor.hexColor(0xF99E66)
        $0.textAlignment = .center
        $0.textColor = UIColor.white
        $0.font = UIFont.systemFont(ofSize: 13)
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

extension LXFHomeRecRecommendCell {
    private func initUI() {
        baseView.addSubview(recLabel)
        recLabel.snp.makeConstraints { (make) in
            make.width.equalTo(57)
            make.height.equalTo(18)
            make.left.equalTo(baseView.titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

