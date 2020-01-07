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
    }
    
    func next() {
        print("[SplashController] next")
        
        // 获取到 当前 应用对应的 AppDelegate对象
        // 全局 只有一个
        
        //         //
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //
        //        appDelegate.toGuide()
        
        AppDelegate.shared.toGuide()
    }
}

