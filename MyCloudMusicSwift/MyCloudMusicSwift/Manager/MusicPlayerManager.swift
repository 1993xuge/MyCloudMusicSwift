//
//  File.swift
//  MyCloudMusicSwift
//  音乐播放管理器
//  封装了常用的音乐播放功能
//  例如：播放，暂停，继续播放等功能
//  目的就是对外面提供统一的接口
//  好处是内部自由的重构
//  只需要对外部接口不变
//
//  Created by wangyixu on 2020/1/17.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

class MusicPlayerManager {

    private static var instance: MusicPlayerManager?

    /// 获取单例的播放管理器
    ///
    static func shared() -> MusicPlayerManager {
        if instance == nil {
            instance = MusicPlayerManager()
        }
        return instance!
    }
}
