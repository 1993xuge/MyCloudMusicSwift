//
//  BaseModel.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation
import HandyJSON

class BaseModel: HandyJSON {

    /// Id
    var id: String!

    /// 创建时间
    var created_at: String = ""

    /// 创建时间
    var updated_at: String = ""


    //JSON解析框架需要一个默认的init方法
    required init() { }
}
