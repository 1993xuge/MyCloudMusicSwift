//
//  SheetWrapper.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

//导入JSON解析框架
import HandyJSON

class SheetWrapper: HandyJSON {

    /// 歌单数据
    var data: Sheet!

    //因为HandyJSON解析框架要求有一个init方法
    required init() { }
}
