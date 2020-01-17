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

//导入媒体模块
import MediaPlayer

class MusicPlayerManager {

    private static var instance: MusicPlayerManager?

    /// 播放状态
    var status: PlayStatus = .none

    /// 播放器
    var player: AVPlayer!

    /// 当前音乐
    var data: Song!

    /// 播放代理
    var delegate: MusicPlayerDelegate?

    /// 获取单例的播放管理器
    ///
    static func shared() -> MusicPlayerManager {
        if instance == nil {
            instance = MusicPlayerManager()
        }
        return instance!
    }

    /// 初始化
    init() {
        player = AVPlayer.init()
    }

    /// 播放
    ///
    func play(_ uri: String, _ song: Song) {

        //更改播放状态
        status = .playing

        //保存音乐对象
        self.data = song

        let url = URL(string: uri)!

        //创建一个播放Item
        let playerItem = AVPlayerItem(url: url)

        //替换掉原来的播放Item
        player.replaceCurrentItem(with: playerItem)

        //播放
        player.play()

        delegate?.onPlaying(data!)
    }

    /// 暂停
    func pause() {

        //更改状态
        status = .pause

        //暂停
        player.pause()
        delegate?.onPaused(data!)
    }

    /// 继续播放
    func resume() {

        //更改播放状态
        status = .playing

        //播放
        player.play()
        delegate?.onPlaying(data!)
    }

    /// 是否在播放
    ///
    func isPlaying() -> Bool {
        return status == .playing
    }
}

/// 播放状态
///
/// - none: 没有播放
/// - playing: 播放中
/// - pause: 暂停中
/// - error: 播放失败了
enum PlayStatus {
    case none
    case playing
    case pause
    case error
}

protocol MusicPlayerDelegate {

    /// 暂停了
    ///
    func onPaused(_ data: Song)

    /// 正在播放
    ///
    func onPlaying(_ data: Song)
}
