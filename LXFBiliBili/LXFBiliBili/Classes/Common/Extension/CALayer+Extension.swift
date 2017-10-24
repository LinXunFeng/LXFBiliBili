//
//  CALayer+Extension.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

extension CALayer {
    // 暂停动画
    func pauseAnimate() {
        self.speed = 0.0
        self.timeOffset = self.convertTime(CACurrentMediaTime(), from: nil)
    }
    
    // 恢复动画
    func resumeAnimate() {
        let paused = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        self.beginTime = self.convertTime(CACurrentMediaTime(), from: nil) - paused
    }
}


