//
//  LXFHomeLiveHeader.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXFHomeLiveHeader: UICollectionReusableView, LXFNibloadable {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setliveCount(_ liveCount: Int) {
        // 当前442个直播，进去看看
        let muStr = NSMutableAttributedString(string: "\(liveCount)", attributes: [NSAttributedStringKey.foregroundColor : UIColor.red])
        
        let frontStr = NSAttributedString(string: "当前", attributes: nil)
        let backStr = NSAttributedString(string: "个直播，进去看看", attributes: nil)
        muStr.insert(frontStr, at: 0)
        muStr.append(backStr)
        descLabel.attributedText = muStr
    }
}

extension LXFHomeLiveHeader: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 30
    }
}
