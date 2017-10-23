//
//  RxAlamofire+ObjectMapper.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/20.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import RxCocoa
import ObjectMapper
import SwiftyJSON

extension ObservableType where E == Any {
    public func lxf_json(_ json : @escaping ((E) -> JSON)) -> Observable<Any> {
        return flatMap { (result) -> Observable<Any> in
            return Observable.just(json(result).object)
        }
    }
    
    // 将Json解析为Observable<Model>
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { json -> Observable<T> in
            guard let object = Mapper<T>().map(JSONObject: json) else {
                LXFLog("ObjectMapper can't mapping Object")
                return Observable.error(NSError(domain: "LinXunFeng", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping Object"]))
            }
            return Observable.just(object)
        }
    }
    // 将Json解析为Observable<[Model]>
    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { (json) -> Observable<[T]> in
            guard let objectArr = Mapper<T>().mapArray(JSONObject: json) else {
                LXFLog("ObjectMapper can't mapping Array")
                return Observable.error(NSError(domain: "LinXunFeng", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping objArray"]))
            }
            return Observable.just(objectArr)
        }
    }
    
//    throw NSError(domain: "LinXunFeng", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping"])
}

