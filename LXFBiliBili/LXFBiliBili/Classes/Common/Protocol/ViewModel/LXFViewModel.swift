//
//  LXFViewModel.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation

protocol LXFViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
