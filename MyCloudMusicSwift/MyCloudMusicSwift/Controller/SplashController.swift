//
//  SplashController.swift
//  MyCloudMusicSwift
//  Splash界面
//  可以添加以下逻辑：
//  1、判断用户是否登录，从而跳转到不同的界面
//  2、判断是否显示引导界面
//  3、获取广告等
//
//  Created by wangyixu on 2020/1/7.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SplashController: UIViewController {


    /// 加载视图成功后调用该方法
    //  类似Android中Activity的onCreate方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // 延迟3s
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                // 延迟了3s后。
                self.next()
            })

        //测试偏好设置

        //获取偏好设置对象
        let userDefault = UserDefaults.standard

        //保存一个字符串
        userDefault.set("w我是 爱学啊", forKey: "user_name")

        var userName = userDefault.string(forKey: "user_name")
        print("SplashController viewDidLoad : set, userName = \(userName)")

        userDefault.removeObject(forKey: "user_name")
        userName = userDefault.string(forKey: "user_name")
        print("SplashController viewDidLoad : remove, userName = \(userName)")
    }

    func next() {
        print("[SplashController] next")
        AppDelegate.shared.toGuide()
    }
}

