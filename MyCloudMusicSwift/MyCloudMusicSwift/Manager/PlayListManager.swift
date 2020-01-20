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

    /// 播放管理器
    var musicPlayerManager: MusicPlayerManager!

    //播放列表
    var datum: [Song] = []

    // 当前播放的音乐
    var data: Song? = nil

    override init() {
        super.init()

        musicPlayerManager = MusicPlayerManager.shared()
    }

    /// 设置播放列表
    ///
    /// - Parameter datum: <#datum description#>
    func setPlayList(_ datum: [Song]) {
        print("PlayListManager setPlayList")

        //清空原来的数据
        self.datum.removeAll()

        //添加新的数据
        self.datum = self.datum + datum
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
    func play(_ position: Int) {
        print("PlayListManager play:\(position)")

        data = datum[position]

        //播放在线音乐
        musicPlayerManager.play(ResourceUtil.resourceUri(data!.uri), data!)
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
