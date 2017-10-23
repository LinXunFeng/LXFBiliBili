//
//  LXFMenuBottomView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/18.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import SnapKit

class LXFMenuBottomView: UIView, LXFNibloadable {
    
    @IBOutlet weak var nightBtn: UIButton!
    
    @IBAction func btnClick(_ sender: UIButton) {
        print(sender.tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
}

extension LXFMenuBottomView: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        if is_iPhoneX {
            return 50.0 + iPhoneXBottomH
        }
        return 50.0
    }
}
