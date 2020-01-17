//
//  SimpletPlayerController.swift
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

class SimpletPlayerController: BaseTitleController {

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

    override func initViews() {
        super.initViews()
    }

    override func initDatas() {
        super.initDatas()

        //获取音乐播放管理器
        musicPlayerManager = MusicPlayerManager.shared()

        //测试音乐数据
        let songUrl = "http://dev-courses-misuc.ixuea.com/assets/s1.mp3"

        let song = Song()
        song.uri = songUrl

        musicPlayerManager.play(songUrl, song)
    }

    /// 播放或者暂停
    func playOrPause() {
        if musicPlayerManager.isPlaying() {
            musicPlayerManager.pause()
        } else {
            musicPlayerManager.resume()
        }
    }

    // MARK: - 按钮相关事件

    /// 上一曲
    ///
    @IBAction func onPreviousClick(_ sender: Any) {
        print("SimplePlayerController onPreviousClick")
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
    }

    /// 循环模式
    ///
    @IBAction func onLoopModelClick(_ sender: UIButton) {
        print("SimplePlayerController onLoopModelClick")
    }

}


// MARK: - 启动界面
extension SimpletPlayerController {

    /// 启动界面
    ///
    static func start(_ navigationController: UINavigationController) {

        //创建控制器
        let controller = navigationController.storyboard!.instantiateViewController(withIdentifier: "SimpletPlayer")

        //将控制器压入导航控制器
        navigationController.pushViewController(controller, animated: true)
    }
}
