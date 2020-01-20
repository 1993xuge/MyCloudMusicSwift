//
//  SimplePlayerController.swift
//  MyCloudMusicSwift
//  简单的音乐播放实现
//  主要测试音乐播放相关逻辑
//  因为黑胶唱片界面的逻辑比较复杂
//  如果在和播放相关逻辑混一起，不好实现
//  所有我们可以先使用一个简单的播放器
//  从而把播放器相关逻辑实现完成
//  然后在对接的黑胶唱片
//  就相对来说简单一点
//
//  Created by wangyixu on 2020/1/17.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SimplePlayerController: BaseTitleController {

    /// 音乐播放列表
    @IBOutlet weak var tableView: UITableView!

    /// 标题
    @IBOutlet weak var lbTitle: UILabel!

    /// 当前播放时间
    @IBOutlet weak var lbStart: UILabel!

    /// 进度条
    @IBOutlet weak var sdProgress: UISlider!

    /// 音乐总时间
    @IBOutlet weak var lbEnd: UILabel!

    /// 播放按钮
    @IBOutlet weak var btPlay: UIButton!

    /// 循环模式
    @IBOutlet weak var btLoopModel: UIButton!

    /// 播放管理器
    var musicPlayerManager: MusicPlayerManager!

    /// 播放列表管理器
    var playListManager: PlayListManager!

    /// 是否按下了进度条
    var isSlideTouch = false

    override func initViews() {
        super.initViews()
    }

    override func initDatas() {
        super.initDatas()

        //获取播放列表管理器
        playListManager = PlayListManager.shared

        //获取音乐播放管理器
        musicPlayerManager = MusicPlayerManager.shared()

        //显示播放状态
        showMusicPlayStatus()

        //显示音乐时长
        showDuration()
        
        //显示进度
        showProgress()
        
        //显示循环模式
        showLoopModel()
    }

    /// 播放或者暂停
    func playOrPause() {
        if musicPlayerManager.isPlaying() {
            playListManager.pause()
        } else {
            playListManager.resume()
        }
    }

    // MARK: - 按钮相关事件

    /// 上一曲
    ///
    @IBAction func onPreviousClick(_ sender: Any) {
        print("SimplePlayerController onPreviousClick")

        let song = playListManager.previous()
        playListManager.play(song)
    }

    /// 播放按钮
    ///
    @IBAction func onPlayClick(_ sender: UIButton) {
        print("SimplePlayerController onPlayClick")

        playOrPause()
    }

    /// 下一曲
    ///
    @IBAction func onNextClick(_ sender: UIButton) {
        print("SimplePlayerController onNextClick")
        playListManager.play(playListManager.next())
    }

    /// 循环模式
    ///
    @IBAction func onLoopModelClick(_ sender: UIButton) {
        print("SimplePlayerController onLoopModelClick")

        //切换循环模式
        playListManager.changeLoopModel()

        //显示当前循环模式
        showLoopModel()
    }

    // MARK: - 进度条相关

    /// 进度条拖拽回调
    ///
    @IBAction func onProgressChanged(_ sender: UISlider) {
        //将拖拽进度显示到界面
        //用户就很方便的知道自己拖拽到什么位置
        lbStart.text = TimeUtil.second2MinuteAndSecond(sender.value)

        //音乐切换到拖拽位置播放
//        musicPlayerManager.seekTo(sender.value)
    }

    /// 进度条按下
    ///
    @IBAction func onSlideTouchDown(_ sender: UISlider) {

        print("SimplePlayerController onSlideTouchDown")

        isSlideTouch = true
    }

    /// 进度条抬起
    ///
    @IBAction func onSlideTouchUp(_ sender: UISlider) {
        print("SimplePlayerController onSlideTouchUp")

        isSlideTouch = false

        if sender.value > 1 {
            //减一是为了用户能听清前一秒
            //音乐可能没那么明显
            //但视频继续播放的时候最好减一秒
            musicPlayerManager.seekTo(sender.value-1)
        }
    }

    /// 视图即将可见方法
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //设置播放代理
        musicPlayerManager.delegate = self
    }

    /// 视图即将消失
    ///will：即将
    ///did：已经
    ///其他方法命名也都有这个规律
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //取消代理
        musicPlayerManager.delegate = nil
    }


    /// 显示播放状态
    func showPlayStatus() {
        btPlay.setTitle("播放", for: .normal)
    }

    /// 显示暂停状态
    func showPauseStatus() {
        btPlay.setTitle("暂停", for: .normal)
    }

    /// 显示播放状态
    func showMusicPlayStatus() {
        if musicPlayerManager.isPlaying() {
            showPauseStatus()
        } else {
            showPlayStatus()
        }
    }

    /// 显示播放总时长
    func showDuration() {
        let duration = musicPlayerManager.data!.duration

        if duration > 0 {
            lbEnd.text = TimeUtil.second2MinuteAndSecond(duration)
            sdProgress.maximumValue = duration
        }
    }

    /// 显示进度
    func showProgress() {
        let progress = musicPlayerManager.data!.progress

        if progress > 0 {
            if !isSlideTouch {
                lbStart.text = TimeUtil.second2MinuteAndSecond(progress)
                sdProgress.value = progress
            }
        }
    }

    /// 显示循环模式
    func showLoopModel() {
        //获取当前循环模式
        let model = playListManager.getLoopModel()

        switch model {
        case .list:
            btLoopModel.setTitle("列表循环", for: .normal)
        case .random:
            btLoopModel.setTitle("随机循环", for: .normal)
        default:
            btLoopModel.setTitle("单曲循环", for: .normal)
        }
    }
}


// MARK: - 启动界面
extension SimplePlayerController {

    /// 启动界面
    ///
    static func start(_ navigationController: UINavigationController) {

        //创建控制器
        let controller = navigationController.storyboard!.instantiateViewController(withIdentifier: "SimpletPlayer")

        //将控制器压入导航控制器
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: - 播放代理

extension SimplePlayerController: MusicPlayerDelegate {

    /// 播放器准备完毕了
    ///
    func onPrepared(_ data: Song) {
        print("SimplePlayController onPrepared duration:\(data.duration)")

        showDuration()
    }

    /// 暂停了
    ///
    func onPaused(_ data: Song) {
        showPlayStatus()
    }

    /// 播放中
    ///
    func onPlaying(_ data: Song) {

        showPauseStatus()
    }

    /// 进度回调
    ///
    /// - Parameter data: <#data description#>
    func onProgress(_ data: Song) {
        print("SimplePlayerController onProgress:\(data.progress),\(data.duration)")
        showProgress()
    }
}
