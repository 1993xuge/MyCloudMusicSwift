//
//  ListResponse.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

import HandyJSON

class ListResponse<T:HandyJSON>: BaseResponse {

    /// 定义一个列表
    /// 里面的对象使用了泛型
    var data: Array<T>?
}
