//
//  BaseResponse.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation
import HandyJSON

class BaseResponse: HandyJSON {
    
    /// 状态码
    /// 只有发生了错误才会有
    var status:Int?
    
    /// 错误信息
    /// 发生了错误不一定有
    var message:String?
    
    // JSON解析 需要的方法
    required init() { }
}
