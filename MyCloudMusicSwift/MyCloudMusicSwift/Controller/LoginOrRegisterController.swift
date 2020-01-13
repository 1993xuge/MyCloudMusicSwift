//
//  LoginOrRegisterController.swift
//  MyCloudMusicSwift
//  登录/注册界面
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class LoginOrRegisterController: BaseCommonController {

    // 登录
    @IBOutlet weak var btnLogin: UIButton!

    // 注册
    @IBOutlet weak var btnRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()
        // 设置 边框
        btnLogin.showColorPrimaryBorder()
        btnRegister.showColorPrimaryBorder()

        // 设置圆角
        ViewUtil.showLargeRadius(view: btnLogin)
        ViewUtil.showLargeRadius(view: btnRegister)
    }
    
    /// 视图即将可见
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("LoginOrRegisterController viewWillAppear")
        
        //隐藏导航栏
        navigationController!.setNavigationBarHidden(true, animated: true)
    }
    
    /// 视图即将消息
    /// will:即将
    /// did:已经
    /// 其他方法也是遵循这个命名规范的
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("LoginOrRegisterController viewWillDisappear")
        
        //显示导航栏
        //因为其他界面可能不需要隐藏
        navigationController!.setNavigationBarHidden(false, animated: true)
    }

    /// 按下
    ///
    /// - Parameter sender: 按下的btn
    @IBAction func touchDown(_ sender: UIButton) {
        // 设置 按钮 按下的颜色
        sender.backgroundColor = UIColor(hex: COLOR_PRIMARY)
    }


    /// 抬起，在按钮内 抬起
    ///
    /// - Parameter sender: 抬起的btn
    @IBAction func touchUp(_ sender: UIButton) {
        // 设置 按钮 抬起的颜色
        sender.backgroundColor = UIColor.white

        if sender == btnLogin {
            // 登录
            toLogin()
        } else {
            // 注册
            toRegister()
        }
    }

    /// 抬起，在按钮外抬起
    ///
    /// - Parameter sender: 抬起的btn
    @IBAction func touchUpOutside(_ sender: UIButton) {
        touchUp(sender)
    }

    func toLogin() {
        print("LoginOrRegisterController toLogin")

        let controller = storyboard!.instantiateViewController(withIdentifier: "Login")

        navigationController?.pushViewController(controller, animated: true)
    }

    func toRegister(type: SSDKPlatformType? = nil, avatar: String? = nil, nickname: String? = nil, openId: String? = nil) {
        print("LoginOrRegisterController toRegister ")

        let controller = storyboard!.instantiateViewController(withIdentifier: "Register") as! RegisterController

        //传递参数
        controller.avatar = avatar
        controller.nickname = nickname
        controller.openId = openId
        controller.type = type

        // 将 控制器 要入到 导航控制器
        navigationController?.pushViewController(controller, animated: true)
    }

//MARK: - 第三方登录

/// 微信登录
///
/// - Parameter sender: <#sender description#>
    @IBAction func onWechatLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onWechatLoginClick")
    }

/// QQ登录按钮点击
///
/// - Parameter sender: <#sender description#>
    @IBAction func onQQLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onQQLoginClick")
        otherLogin(.typeQQ)
    }

/// 微博登录按钮点击
///
/// - Parameter sender: <#sender description#>
    @IBAction func onWeiboLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onWeiboLoginClick")
        otherLogin(.typeSinaWeibo)
    }

/// 网易邮箱登录按钮点击
///
/// - Parameter sender: <#sender description#>
    @IBAction func onNeteaseLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onNeteaseLoginClick")
    }

    /// 通用第三方登录
    ///
    /// - Parameter type: type description
    func otherLogin(_ type: SSDKPlatformType) {
        ShareSDK.getUserInfo(type) { (state, user, error) in
            // (SSDKResponseState, SSDKUser?, Error?)
            if state == .success {
                // 微博 登录成功
                //就可以获取到昵称，头像，OpenId
                let nickname = user?.nickname
                let avatar = user?.icon
                let openId = user?.credential.token

                print("LoginOrRegisterController onWeiboLoginClick login success:\(nickname),\(avatar),\(openId)")

                self.continueLogin(type: type, avatar: avatar!, nickname: nickname!, openId: openId!)
            } else {
                //登录失败
                print("LoginOrRegisterController onWeiboLoginClick login failed:\(error)")
                ToastUtil.short("登录失败，请稍后再试！")
            }
        }
    }

    /// 继续登录
    ///
    /// - Parameters:
    ///   - avatar: 昵称
    ///   - nickname: 头像
    ///   - openId: 第三方登录后用户Id
    func continueLogin(type: SSDKPlatformType, avatar: String, nickname: String, openId: String) {
        print("LoginOrRegisterController continueLogin:\(avatar),\(nickname),\(openId)")

        var api: Observable<DetailResponse<Session>?>!

        if type == .typeQQ {
            //把openId传递到qq_id参数上面
            api = Api.shared.login(qq_id: openId)
        } else {
            //把openId传递到weibo_id参数上面
            api = Api.shared.login(weibo_id: openId)
        }
        //先调用登录接口
        //如果接口返回用户不存在（根据code判断）
        //就跳转到补充用户资料页面
        //如果存在其实就完成了登录
        //后面的逻辑和正常登录一样
        api.subscribe({ data in
            //登录成功
            //表示用户已经注册了（补充资料了）
            //把登录完成的事件回调到AppDelegate
            AppDelegate.shared.onLogin(data!.data!)
        }) { (baseResponse, error) -> Bool in
            //登录失败
            //判断具体的错误类型
            if let baseResponse = baseResponse {
                // 请求成功了
                //并且服务端返回了错误信息

                //判断错误码
                if 1010 == baseResponse.status {
                    // 用户未注册
                    //跳转到补充用户资料页面
                    self.toRegister(type: type, avatar: avatar, nickname: nickname, openId: openId)

                    //返回true就表示我们处理了错误
                    return true
                }
            }
            //这里我们就不管是什么错误类型了
            //直接让框架处理
            return false
        }.disposed(by: disposeBag)
    }

//    enum LoginType {
//        case QQ
//        case WEIBO
//    }
}
