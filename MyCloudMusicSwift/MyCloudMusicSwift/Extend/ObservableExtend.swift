//
//  ObservableExtend.swift
//  MyCloudMusicSwift
//  添加了一些解析对象的方法
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

//导入响应式编程框架
import RxSwift

//导入JSON解析框架
import HandyJSON

//导入网络框架
import Moya

//MARK: - 自定义 错误
/// 自定义错误
///
/// - objectMapping: 表示JSON解析为对象失败
public enum IxueaError: Swift.Error {
    case objectMapping
}

// MARK: - 扩展Observable
extension Observable {

    /// 将字符串解析为对象
    ///
    /// - Parameter type: 要转为的类
    /// - Returns: 转换后的观察者对象
    public func mapObject<T:HandyJSON>(_ type: T.Type) -> Observable<T?> {
        return self.map({ data in
            //将参数尝试转为字符串

            guard let dataString = data as? String else {
                //data不能转为字符串
                return nil
            }

            if dataString.isEmpty {
                // 空字符串
                return nil
            }

            guard let result = type.deserialize(from: dataString) else {
                //转为对象失败
                throw IxueaError.objectMapping
            }

            // 解析成功
            return result
        })
    }
}

// MARK: - 扩展ObservableType
// 目的是添加两个自定义监听方法
// 一个是只观察请求成功的方法
// 一个既可以观察请求成功也可以观察请求失败
extension ObserverType {

    /// 观察成功和失败事件
    ///
    /// - Parameters:
    ///   - onSuccess: 请求成功的回调
    ///   - onError: 请求失败的回调
    /// - Returns: <#return value description#>
    func subscribe(
        _ onSuccess: @escaping ((E) -> Void),
        _ onError: @escaping((BaseResponse?, Error?) -> Bool)
    ) -> Disposable {

    }

  
    /// 观察成功的事件
    ///
    /// - Parameter onSuccess: <#onSuccess description#>
    /// - Returns: <#return value description#>
    func subscribeOnSuccess(_ onSuccess: @escaping ((E) -> Void) ) -> Disposable {
        
    }
    func subscribeOnSuccess(_ onSuccess: @escaping((E) -> Void)) -> Disposable {

    }
}
