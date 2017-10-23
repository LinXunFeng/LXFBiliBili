//
//  UINavigationBar+FixSpace.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

var lxf_disableFixSpace = false
// navigationBarItem的间距
var lxf_defaultLeftFixSpace: CGFloat = 0
var lxf_defaultRightFixSpace: CGFloat = 8

import UIKit

extension UIImagePickerController {
    static func fixNavitionBarItemSpace() {
        methodSwizze(cls: UIImagePickerController.classForCoder(), originalSelector: #selector(viewWillAppear(_:)), swizzeSelector: #selector(lxf_viewWillAppear(_:)))
    }
    
    @objc private func lxf_viewWillAppear(_ animated: Bool) {
        lxf_disableFixSpace = true
        self.lxf_viewWillAppear(animated)
    }
    
    @objc private func lxf_viewWillDisappear(_ animated: Bool) {
        lxf_disableFixSpace = false
        self.lxf_viewWillAppear(animated)
    }
}

extension UINavigationBar {
    static func fixNavitionBarItemSpace() {
        methodSwizze(cls: UINavigationBar.classForCoder(), originalSelector: #selector(layoutSubviews), swizzeSelector: #selector(lxf_layoutSubviews))
    }
    
    @objc private func lxf_layoutSubviews() {
        self.lxf_layoutSubviews()
        
        //  && lxf_disableFixSpace
        if #available(iOS 11.0, *) { // 需要调节
            self.layoutMargins = UIEdgeInsets.zero
            let leftSpace: CGFloat = lxf_defaultLeftFixSpace
            let rightSpace: CGFloat = lxf_defaultRightFixSpace
            for subview in subviews {
                if NSStringFromClass(subview.classForCoder).contains("ContentView") {
                    subview.layoutMargins = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace) // 可修正iOS11之后的偏移
                    break
                }
            }
        }
    }
}

extension UINavigationItem {
    static func fixNavitionBarItemSpace() {
        
        methodSwizze(cls: UINavigationItem.classForCoder(), originalSelector: #selector(setter: leftBarButtonItems), swizzeSelector: #selector(setter: lxf_leftBarButtonItems))
        methodSwizze(cls: UINavigationItem.classForCoder(), originalSelector: #selector(setter: rightBarButtonItems), swizzeSelector: #selector(setter: lxf_rightBarButtonItems))
        methodSwizze(cls: UINavigationItem.classForCoder(), originalSelector: #selector(setter: leftBarButtonItem), swizzeSelector: #selector(setter: lxf_leftBarButtonItem))
        methodSwizze(cls: UINavigationItem.classForCoder(), originalSelector: #selector(setter: rightBarButtonItem), swizzeSelector: #selector(setter: lxf_rightBarButtonItem))
    }
    
    @objc private var lxf_leftBarButtonItem: UIBarButtonItem {
        get {
            return self.lxf_leftBarButtonItem
        }
        set {
            if #available(iOS 11.0, *) {
                self.lxf_leftBarButtonItem = newValue
            } else {
                guard let `leftBarButtonItem` = leftBarButtonItem else {
                    // 不存在按钮
                    self.lxf_leftBarButtonItem = newValue
                    return
                }
                if !lxf_disableFixSpace {  // 存在按钮且需要调节
                    leftBarButtonItems = [leftBarButtonItem]
                } else { // 不需要调节
                    self.lxf_leftBarButtonItem = newValue
                }
            }
        }
    }
    
    @objc private var lxf_leftBarButtonItems: [UIBarButtonItem] {
        get {
            return self.lxf_leftBarButtonItems
        } set {
            if newValue.count > 0 {
                // 这个加上反而多了20px
                // var lxf_items = [fixedSpace(width: lxf_defaultLeftFixSpace - 20)]
                var lxf_items = [UIBarButtonItem]()
                lxf_items = lxf_items + newValue
                self.lxf_leftBarButtonItems = lxf_items
            } else {
                self.lxf_leftBarButtonItems = newValue
            }
        }
    }
    
    @objc private var lxf_rightBarButtonItem: UIBarButtonItem {
        get {
          return self.lxf_rightBarButtonItem
        } set {
            if #available(iOS 11.0, *) {
                self.lxf_rightBarButtonItem = newValue
            } else {
                guard let rightBarButtonItem = rightBarButtonItem else {
                    // 不存在按钮
                    self.lxf_rightBarButtonItem = newValue
                    return
                }
                if !lxf_disableFixSpace {  // 存在按钮且需要调节
                    rightBarButtonItems = [rightBarButtonItem]
                } else { // 不需要调节
                    self.lxf_rightBarButtonItem = newValue
                }
            }
        }
    }
    
    @objc private var lxf_rightBarButtonItems: [UIBarButtonItem] {
        get {
            return self.lxf_rightBarButtonItems
        } set {
            if newValue.count > 0 {
                // 这个加上反而多了20px
                // var lxf_items = [fixedSpace(width: lxf_defaultRightFixSpace - 20)]
                var lxf_items = [UIBarButtonItem]()
                lxf_items = lxf_items + newValue
                self.lxf_rightBarButtonItems = lxf_items
            } else {
                self.lxf_rightBarButtonItems = newValue
            }
        }
    }
    
    private func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = width
        return fixedSpace
    }
    
}
