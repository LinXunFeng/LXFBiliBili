//
//  LXFRecommendTopView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXFRecommendTopView: UIView, LXFNibloadable, LXFViewHeightProtocol {
    
    @IBOutlet weak var multipleBtn: UIButton!
    @IBOutlet weak var rankBtn: UIButton!
    @IBOutlet weak var tagBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = kThemeBackgroundColor
        
        multipleBtn.rx.tap.subscribe(onNext: { () in
            LXFLog("综合")
        }).disposed(by: rx.disposeBag)
        rankBtn.rx.tap.subscribe(onNext: { () in
            LXFLog("排行榜")
        }).disposed(by: rx.disposeBag)
        rankBtn.rx.tap.subscribe(onNext: { () in
            LXFLog("标签")
        }).disposed(by: rx.disposeBag)
        
    }
    
    static func viewHeight() -> CGFloat {
        return 50
    }
    
}
