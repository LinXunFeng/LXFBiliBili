//
//  Runtime+Extension.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation

extension NSObject {
    // 获取属性和方法
    func showClsRuntime (cls : AnyClass)  {
        print("start methodList")
        var  methodNum : UInt32 = 0
        guard let methodList = class_copyMethodList(cls, &methodNum) else {
            return
        }
        for index in 0..<numericCast(methodNum) {
            let method : Method = methodList[index]
            print(String(cString: method_getTypeEncoding(method)!, encoding: String.Encoding.utf8) ?? "")
            print(String(cString: method_copyReturnType(method), encoding: String.Encoding.utf8) ?? "")
            print(String(_sel: method_getName(method)))
        }
        free(methodList)
        print("end methodList")
        
        print("start propertyList")
        
        var propertyNum : UInt32 = 0
        guard let propertyList = class_copyPropertyList(cls, &propertyNum) else {
            return
        }
        for index in 0..<numericCast(propertyNum) {
            let property : objc_property_t = propertyList[index]
            
            print(String(cString: property_getName(property), encoding: String.Encoding.utf8) ?? "")
            print(String(cString: property_getAttributes(property)!, encoding: String.Encoding.utf8) ?? "")
        }
        free(propertyList)
        print("end propertyList")
        
    }
    
    
    ///Method Swizzeing runtime动态替换方法
    static func methodSwizze(cls : AnyClass ,originalSelector : Selector , swizzeSelector : Selector)  {
        guard let originalMethod = class_getInstanceMethod(cls, originalSelector),let swizzeMethod = class_getInstanceMethod(cls, swizzeSelector) else {
            return
        }
        let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzeMethod), method_getTypeEncoding(swizzeMethod))
        
        if didAddMethod {
            class_replaceMethod(cls, swizzeSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        }else {
            method_exchangeImplementations(originalMethod, swizzeMethod)
        }
        
    }
}
