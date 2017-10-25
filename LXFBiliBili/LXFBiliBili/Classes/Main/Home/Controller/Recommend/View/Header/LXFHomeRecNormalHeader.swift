//
//  LXFHomeRecNormalHeader.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFHomeRecNormalHeader: UICollectionReusableView, LXFViewHeightProtocol {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    static func viewHeight() -> CGFloat {
        return 164
    }
}
