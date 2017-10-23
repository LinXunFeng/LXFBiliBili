//
//  LXFHomeLiveBannerDataHeader.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/22.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import Kingfisher

class LXFHomeLiveBannerDataHeader: UICollectionReusableView {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension LXFHomeLiveBannerDataHeader: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 167
    }
}
