//
//  Ad.swift
//  MyCloudMusicSwift
//  广告模型
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class Ad: BaseModel {
    /// 标题
    var title:String!
    
    /// 图片
    var banner:String!
    
    /// 点击广告后跳转的地址
    var uri:String!
}
