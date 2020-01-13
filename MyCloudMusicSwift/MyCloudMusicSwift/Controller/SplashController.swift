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

class SplashController: BaseController {


    /// 加载视图成功后调用该方法
    //  类似Android中Activity的onCreate方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // 延迟3s
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                // 延迟了3s后。
//                self.next()
//            })
        self.next()
    }

    func next() {
        print("[SplashController] next")

        if(PreferenceUtil.isShowGuide()) {
            AppDelegate.shared.toGuide()
        } else if PreferenceUtil.isLogin() {
            //表示已经登录了
            
            //所以直接跳转到首页
            // AppDelegate.shared.toHome()
            
            //显示广告页面
            //就显示广告页面
            //在广告页面再进入主界面
            //可以根据自己的需求来更改
            //同时只有用户登陆了
            //才显示也给用户有更好的体验
            AppDelegate.shared.toAd()
        } else {
            AppDelegate.shared.toLoginOrRegister()
        }
    }
}

