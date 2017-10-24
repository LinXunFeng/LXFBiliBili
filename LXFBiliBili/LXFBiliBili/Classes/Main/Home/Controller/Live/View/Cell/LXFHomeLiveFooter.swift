//
//  LXFHomeLiveFooter.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXFHomeLiveFooter: UICollectionReusableView, LXFNibloadable {
    @IBOutlet weak var swapBtn: UIButton!
    @IBOutlet weak var refreshIconView: UIImageView!
    private var keepAnimate = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initLayer()
        
        swapBtn.rx.tap.subscribe(onNext: { () in
            if !self.keepAnimate {
                self.refreshIconView.layer.resumeAnimate()
            } else {
                self.refreshIconView.layer.pauseAnimate()
                self.refreshIconView.transform = CGAffineTransform.identity
            }
            self.keepAnimate = !self.keepAnimate
        }).disposed(by: rx.disposeBag)
    }
    
    func initLayer() {
        // swapBtn
        swapBtn.layer.borderColor = kThemePinkColor.cgColor
        swapBtn.layer.borderWidth = 1
        swapBtn.layer.cornerRadius = 16
        
        // 初始化旋转动画
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = -Double.pi
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        self.refreshIconView.layer.add(rotationAnimation, forKey: "lxf.transform.rotation.z")
        self.refreshIconView.layer.pauseAnimate()
    }
}

extension LXFHomeLiveFooter: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 55
    }
}
