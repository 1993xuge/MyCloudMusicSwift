//
//  DetailResponse.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

import HandyJSON

/// 继承BaseResponse
/// 定义了一个泛型T
/// 返回必须实现了HandyJSON协议
/// 因为我们希望用户传递的类要能解析为JSON
class DetailResponse<T:HandyJSON>: BaseResponse {

    /// 真实数据
    /// 他的类型就是返回
    var data: T?
}
