//
//  LXFMenuTopView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFMenuTopView: UIView, LXFNibloadable {
    
    @IBOutlet fileprivate weak var avatarImgBtn: UIButton!
    @IBOutlet fileprivate weak var avatarTextBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImgBtn.layer.cornerRadius = avatarImgBtn.width * 0.5
        avatarImgBtn.layer.masksToBounds = true
    }

    
}

extension LXFMenuTopView: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        if is_iPhoneX {
            return 150 + iPhoneXTopH
        }
        return 150.0
    }
}
