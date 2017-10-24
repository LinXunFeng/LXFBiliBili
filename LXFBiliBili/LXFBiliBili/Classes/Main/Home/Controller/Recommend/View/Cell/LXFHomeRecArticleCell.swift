//
//  LXFHomeRecArticleCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeRecArticleCell: UICollectionViewCell, LXFHomeRecBaseCellable {
    var baseView: LXFHomeRecCellTopView!
    
    let borderLabel = UILabel().then {
        $0.text = "文章"
        $0.textAlignment = .center
        $0.textColor = kThemePinkColor
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
        $0.layer.borderColor = kThemePinkColor.cgColor
        $0.layer.borderWidth = 1
    }
    let categoryLabel = UILabel().then {
        $0.text = "游戏"
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

extension LXFHomeRecArticleCell {
    private func initUI() {
        baseView.addSubview(borderLabel)
        borderLabel.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(16)
            make.left.equalTo(baseView.titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        baseView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(borderLabel)
            make.right.equalTo(baseView.moreBtn.snp.left)
            make.left.equalTo(borderLabel.snp.right).offset(5)
        }
    }
}
