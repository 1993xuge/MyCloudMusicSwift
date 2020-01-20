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

    /// 是否播放了音乐
    var isPlay = false

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

        play(data!)
    }
    
    /// 播放当前音乐
    ///
    /// - Parameter data: <#data description#>
    func play(_ data:Song) {
        //播放在线音乐
        musicPlayerManager.play(ResourceUtil.resourceUri(data.uri), data)
        
        //标记为播放了
        isPlay = true
    }

    /// 暂停
    func pause() {
        print("PlayListManager pause")
        musicPlayerManager.pause()
    }

    /// 继续播放
    func resume() {
        print("PlayListManager resume")

        if isPlay {
            //播放管理器已经播放过音乐了
            musicPlayerManager.resume()
        } else {
            //还没有进行播放
            //第一次打开应用点击继续播放
            play(data!)
            
            //继续播放
            if data!.progress > 1 {
                //有播放记录
                //继续播放
                musicPlayerManager.seekTo(data!.progress-1)
            }
        }
    }
}
