//
//  Common.swift
//  LXFBiliBili
//
//  Created by xiaozikeji on 2017/10/16.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
//适配iPhoneX
let is_iPhoneX = (kScreenW == 375.0 && kScreenH == 812.0 ?true:false)
let kNavibarH: CGFloat = is_iPhoneX ? 88.0 : 64.0
let kTabbarH: CGFloat = is_iPhoneX ? 49.0+34.0 : 49.0
let kStatusbarH: CGFloat = is_iPhoneX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0



// MARK:- 颜色方法
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK:- 常用按钮颜色
let kThemePinkColor = UIColor.hexColor(0xF5769B)
let kThemeGrayColor = UIColor.hexColor(0xA5A5A5)
let kThemeBackgroundColor = UIColor.hexColor(0xF4F4F4)


// MARK:- 自定义打印方法
func LXFLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}
