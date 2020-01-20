//
//  PlayListManager.swift
//  MyCloudMusicSwift
//  歌单列表管理器
//  主要是封装了列表相关的操作
//  例如：上一曲，下一曲，循环模式等功能
//
//  Created by wangyixu on 2020/1/20.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class PlayListManager: NSObject {

    //单例设计模式
    static var shared = PlayListManager()

    //播放列表
    var datum: [Song] = []

    /// 设置播放列表
    ///
    /// - Parameter datum: <#datum description#>
    func setPlayList(_ datum: [Song]) {
        print("PlayListManager setPlayList")
    }

    /// 获取播放列表
    ///
    /// - Returns: <#return value description#>
    func getPlayList() -> [Song] {
        print("PlayListManager getPlayList")
        return datum
    }

    /// 播放
    ///
    /// - Parameter position: <#position description#>
    func play(_ position:Int) {
        print("PlayListManager play:\(position)")
    }
    
    /// 暂停
    func pause() {
        print("PlayListManager pause")
    }
    
    /// 继续播放
    func resume() {
        print("PlayListManager resume")
    }
}
