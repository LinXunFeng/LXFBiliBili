//
//  LXFMenuViewCell.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

class LXFMenuViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        titleLabel.textColor = selected ? kThemePinkColor : UIColor.black
        iconView.tintColor = selected ? kThemePinkColor : UIColor.hexColor(0x515151)
    }
}
