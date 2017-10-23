//
//  LXFHomeLiveFooter.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeLiveFooter: UICollectionReusableView, LXFNibloadable {
    @IBOutlet weak var swapBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        swapBtn.layer.borderColor = kThemePinkColor.cgColor
        swapBtn.layer.borderWidth = 1
        swapBtn.layer.cornerRadius = 16
    }
}

extension LXFHomeLiveFooter: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 55
    }
}
