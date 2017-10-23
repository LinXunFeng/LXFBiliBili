//
//  LXFHomeLiveBottomFooter.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/23.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeLiveBottomFooter: UICollectionReusableView {
    @IBOutlet weak var allLiveBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let swapBtn = LXFHomeLiveFooter.loadFromNib()
        self.addSubview(swapBtn)
        swapBtn.snp.makeConstraints({ (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(LXFHomeLiveFooter.viewHeight())
        })
        
        allLiveBtn.layer.cornerRadius = 3
        allLiveBtn.layer.masksToBounds = true
        allLiveBtn.layer.borderWidth = 1
        allLiveBtn.layer.borderColor = UIColor.hexColor(0xDBDBDB).cgColor
    }
}

extension LXFHomeLiveBottomFooter: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 40 + LXFHomeLiveFooter.viewHeight()
    }
}
