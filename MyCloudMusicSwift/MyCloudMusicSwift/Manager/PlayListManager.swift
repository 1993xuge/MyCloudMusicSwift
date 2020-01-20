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

    /// 循环模式
    var model: MusicPlayerRepeatModel = .list

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

        play(datum[position])
    }

    /// 播放当前音乐
    ///
    /// - Parameter data: <#data description#>
    func play(_ data: Song) {
        //播放在线音乐
        musicPlayerManager.play(ResourceUtil.resourceUri(data.uri), data)

        //标记为播放了
        isPlay = true
        
        self.data = data
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
                musicPlayerManager.seekTo(data!.progress - 1)
            }
        }
    }

    /// 上一曲
    ///
    /// - Returns: <#return value description#>
    func previous() -> Song {

        var index = 0

        switch model {
        case .random:
            //随机循环
            index = Int(arc4random()) % datum.count
        default:
            //其他模式
            let datumOC = datum as NSArray
            index = datumOC.index(of: data!)

            if index != -1 {
                //找到了

                //判断当前播放的音乐是不是第一首音乐
                if index == 0 {
                    //当前播放的是第一首音乐
                    index = datum.count - 1
                } else {
                    index -= 1
                }
            } else {
                //抛出异常
                //因为正常情况下不会走到了
            }
        }

        print("PlayListManager previous index:\(index)")

        return datum[index]
    }

    /// 下一曲
    ///
    /// - Returns: <#return value description#>
    func next() -> Song {
        var index = 0

        switch model {
        case .random:
            // 随机循环
            //在0~datum.size-1范围中
            //产生一个随机数
            index = Int(arc4random()) % datum.count
        default:
            // 列表循环 和 单曲循环

            // NSArray 存在 index方法，所以 先转换 类型
            let datumOC = datum as NSArray
            index = datumOC.index(of: data!)

            if index != -1 {
                // 找到了

                //如果当前播放的音乐是最后一首音乐
                if index == datum.count - 1 {
                    //当前播放的是最后一首音乐
                    index = 0
                } else {
                    index += 1
                }
            } else {
                //抛出异常
                //因为正常情况下不会走到了
            }
        }

        print("PlayListManager next index:\(index)")

        return datum[index]
    }

    /// 切换循环模式
    ///
    /// - Returns: return value description
    func changeLoopModel() -> MusicPlayerRepeatModel {

        //将当前循环模式转为int
        var model = self.model.rawValue

        //循环模式+1
        model += 1

        //判断边界
        if model > MusicPlayerRepeatModel.random.rawValue {
            //超出了范围
            model = 0
        }
        self.model = MusicPlayerRepeatModel(rawValue: model)!

        return self.model
    }

    /// 获取当前循环模式
    ///
    /// - Returns: <#return value description#>
    func getLoopModel() -> MusicPlayerRepeatModel {
        return model
    }
}

/// 循环模式
///
/// - list: 列表循环
/// - one: 单曲循环
/// - random: 随机循环
enum MusicPlayerRepeatModel: Int {
    case list = 0
    case one
    case random
}

