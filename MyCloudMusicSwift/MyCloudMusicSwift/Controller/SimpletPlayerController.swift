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
