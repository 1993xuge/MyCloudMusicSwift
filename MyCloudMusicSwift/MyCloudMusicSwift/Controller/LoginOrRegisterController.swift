//
//  LoginOrRegisterController.swift
//  MyCloudMusicSwift
//  登录/注册界面
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class LoginOrRegisterController: UIViewController {

    // 登录
    @IBOutlet weak var btnLogin: UIButton!

    // 注册
    @IBOutlet weak var btnRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // 设置 边框
        btnLogin.showColorPrimaryBorder()
        btnRegister.showColorPrimaryBorder()

        // 设置圆角
        ViewUtil.showLargeRadius(view: btnLogin)
        ViewUtil.showLargeRadius(view: btnRegister)
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
    }
    
    func toRegister()  {
        print("LoginOrRegisterController toRegister ")
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
    }
    
    /// 微博登录按钮点击
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onWeiboLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onWeiboLoginClick")
    }
    
    /// 网易邮箱登录按钮点击
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onNeteaseLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onNeteaseLoginClick")
    }
}
