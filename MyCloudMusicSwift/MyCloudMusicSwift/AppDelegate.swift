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

    /// 退出方法
    func logout() {
        //如果需要调用退出接 口
        //就在这里调用就行了

        //清除用户信息
        PreferenceUtil.logout()

        // 清除第三方登录的token
        //清除QQ
        ShareSDK.cancelAuthorize(.typeQQ, result: nil)
        //清除微博
        ShareSDK.cancelAuthorize(.typeSinaWeibo, result: nil)

        //跳转到登录注册页面
        toLoginOrRegister()
    }

    /// 当用户退出了
    func onLogout() {

    }

    /// 当用户登录了
    func onLogin(_ data: Session) {
        PreferenceUtil.setUserId(data.user)
        PreferenceUtil.setUserToken(data.session)

        toHome()
    }

    /// 应用启动时
    /// 全局只调用一次
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initSharedSDK()
//        initTabBar()
        return true
    }

    /// 初始化SharedSDK
    func initSharedSDK() {
        ShareSDK.registPlatforms { register in
            // SSDKRegister?

            //设置QQ信息
            register?.setupQQ(withAppId: QQ_APP_ID, appkey: QQ_APP_SECRET)

            //配置微博
            register?.setupSinaWeibo(withAppkey: WEIBO_APP_KEY, appSecret: WEIBO_APP_SECRET, redirectUrl: WEIBO_REDIRECT_URI)
        }
    }

    /// 初始化TabBar, 全局设置 TabBar的方式
    func initTabBar() {
        // TabBar 选中颜色设置
        UITabBar.appearance().tintColor = UIColor(hex: COLOR_PRIMARY)
    }

    //MARK: - 替换RootVController
    /// 设置跟控制器
    func setRootViewController(name: String) {
        // 先获取 Main.StoryBoard实例
        let mainStory = UIStoryboard(name: "Main", bundle: nil) // 传入nil，会使用bundleid

        // 实例化 Guide场景
        // 因为 场景关联了 控制器
        // 所以说 也可以说 实例化了一个控制器

        let controller = mainStory.instantiateViewController(withIdentifier: name)

        // 替换掉 原来的根控制器
        // 为什么 要通过替换trootViewController的g方式呢？
        //  目的是，不希望用户 还能回调启动界面
        window!.rootViewController = controller
    }

    /// 跳转到 引导界面
    func toGuide() {
        setRootViewController(name: "Guide")
    }

    /// 跳转到登录/注册界面
    func toLoginOrRegister() {
        setRootViewController(name: "LoginOrRegisterNavigation")
    }
    
    /// 显示启动界面后的广告界面
    func toAd() {
        setRootViewController(name: "Ad")
    }

    /// 跳转到首页
    func toHome() {
        setRootViewController(name: "Home")
    }
}
