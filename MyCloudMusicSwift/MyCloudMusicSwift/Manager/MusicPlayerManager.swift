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

class MusicPlayerManager: NSObject {
    static var STATUS = "status"

    private static var instance: MusicPlayerManager?

    /// 播放状态
    var status: PlayStatus = .none

    /// 播放器
    var player: AVPlayer!

    /// 当前音乐
    var data: Song!

    /// 播放代理
    var delegate: MusicPlayerDelegate?

    /// 定时器返回的对象
    var playTimeObserve: Any?

    /// 获取单例的播放管理器
    ///
    static func shared() -> MusicPlayerManager {
        if instance == nil {
            instance = MusicPlayerManager()
        }
        return instance!
    }

    /// 初始化
    override init() {
        super.init()
        player = AVPlayer.init()
    }

    /// 设置监听器
    func initListeners() {
        //KVO方式监听播放状态
        //KVC:Key-Value Coding,另一种获取对象字段的值，类似字典
        //KVO:Key-Value Observing,建立在KVC基础上，能够观察一个字段值的改变
        player.currentItem?.addObserver(self, forKeyPath: MusicPlayerManager.STATUS, options: .new, context: nil)

        //监听播放结束事件
        NotificationCenter.default.addObserver(self, selector: #selector(onComplete(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }

    /// 移除监听器
    func removeListeners() {
        player.currentItem?.removeObserver(self, forKeyPath: MusicPlayerManager.STATUS)

        NotificationCenter.default.removeObserver(self)
    }

    /// 播放完毕了回调
    ///
    /// - Parameter notification: <#notification description#>
    @objc func onComplete(notification: Notification) {
        print("MusicPlayerManager onComplete")
    }

    /// KVO监听回调方法
    ///
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        print("MusicPlayerManager observeValue:\(keyPath)")

        if keyPath == MusicPlayerManager.STATUS {
            //播放状态

            switch player.status {
            case .readyToPlay:
                //准备播放完成了
                self.data!.duration = Float(CMTimeGetSeconds(player.currentItem!.asset.duration))
                print("MusicPlayerManager observeValue duration:\(self.data!.duration)")

                //回调代理
                delegate?.onPrepared(data)
                break

            case .failed:
                //播放失败了
                status = .error

                print("MusicPlayerManager observeValue error")
                break

            default:
                //未知状态
                print("MusicPlayerManager observeValue unknown status")
                break
            }
        }
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

        //设置监听器
        //因为监听器是针对PlayerItem的
        //所以说播放了音乐在这里设置
        initListeners()

        delegate?.onPlaying(data!)

        //启动进度分发定时器
        startPublishProgress()
    }

    /// 暂停
    func pause() {

        //更改状态
        status = .pause

        //暂停
        player.pause()

        //移除监听器
        removeListeners()

        delegate?.onPaused(data!)

        //停止进度分发定时器
        stopPublishProgress()
    }

    /// 继续播放
    func resume() {

        //更改播放状态
        status = .playing

        //播放
        player.play()

        //设置监听器
        initListeners()

        delegate?.onPlaying(data!)

        //启动进度分发定时器
        startPublishProgress()
    }

    /// 从指定位置开始播放
    ///
    /// - Parameter value: <#value description#>
    func seekTo(_ value: Float) {
        let positionTime = CMTime(seconds: Double(value), preferredTimescale: 1)
        player.seek(to: positionTime)
    }

    /// 是否在播放
    ///
    func isPlaying() -> Bool {
        return status == .playing
    }

    /// 开启进度回调通知
    func startPublishProgress() {
        //判断是否启动了
        if let _ = playTimeObserve {
            //已经启动了
            return
        }

        //1/60
        //16毫秒执行一次
        playTimeObserve = player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1.0), timescale: 60), queue: DispatchQueue.main, using: { time in

                //判断是否有代理
                guard let delegate = self.delegate else {
                    //没有回调
                    //停止定时器
                    self.stopPublishProgress()

                    return
                }

                //获取当前音乐播放时间
                self.data!.progress = Float(CMTimeGetSeconds(time))

                print("MusicPlayerManager startPublishProgress progress:\(self.data.progress),\(self.data.duration)")

                //回调代理
                delegate.onProgress(self.data)
            })
    }

    /// 停止进度分发
    func stopPublishProgress() {
        if let playTimeObserve = playTimeObserve {
            player.removeTimeObserver(playTimeObserve)
            self.playTimeObserve = nil
        }
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

    /// 播放器准备完毕了
    /// 可以获取到音乐总时长
    ///
    /// - Parameter data: <#data description#>
    func onPrepared(_ data: Song)

    /// 暂停了
    ///
    func onPaused(_ data: Song)

    /// 正在播放
    ///
    func onPlaying(_ data: Song)

    /// 进度回调
    ///
    /// - Parameter data: <#data description#>
    func onProgress(_ data: Song)
}
