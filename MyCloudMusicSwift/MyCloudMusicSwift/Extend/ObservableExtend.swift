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
