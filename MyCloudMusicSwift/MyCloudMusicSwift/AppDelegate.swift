//
//  AppDelegate.swift
//  MyCloudMusicSwift

//  AppDelegate全局只有一个
//  它的作用是 代理系统的一些事件
//
//  比如：
//  1、App切换到后台、前台等事件
//
//  Created by wangyixu on 2020/1/4.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// 定义一个 静态的计算属性
    /// 返回 AppDelegate对象实例
    open class var shared: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }



    /// 跳转到 引导界面
    func toGuide() {
        // 先获取 Main.StoryBoard实例
        let mainStory = UIStoryboard(name: "Main", bundle: nil) // 传入nil，会使用bundleid

        // 实例化 Guide场景
        // 因为 场景关联了 控制器
        // 所以说 也可以说 实例化了一个控制器


        let controller = mainStory.instantiateViewController(withIdentifier: "Guide")

        // 替换掉 原来的根控制器
        // 为什么 要通过替换trootViewController的g方式呢？
        //  目的是，不希望用户 还能回调启动界面
        window!.rootViewController = controller
    }

    /// 跳转到登录/注册界面
    func toLoginOrRegister() {
        //获取到Main.storyboard
        let mainStory = UIStoryboard(name: "Main", bundle: nil)

        // 实例化 LoginOrRegister 场景
        let controller = mainStory.instantiateViewController(withIdentifier: "LoginOrRegister")

        //替换掉原来的根控制器
        window!.rootViewController = controller
    }
    
    /// 跳转到首页
    func toHome() {
        //获取到Main.storyboard
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        
        // 实例化 LoginOrRegister 场景
        let controller = mainStory.instantiateViewController(withIdentifier: "Home")
        
        //替换掉原来的根控制器
        window!.rootViewController = controller
    }
}
