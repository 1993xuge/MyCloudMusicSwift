//
//  LoginController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class LoginController: BaseLoginController {

    /// 用户名
    @IBOutlet weak var tfUsername: UITextField!

    /// 密码
    @IBOutlet weak var tfPassword: UITextField!

    /// 登录按钮
    @IBOutlet weak var btLogin: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        navigationItem.title = "登录"

        // 显示 图标
        tfUsername.showLeftIcon(name: "LoginItemPhone")
        tfPassword.showLeftIcon(name: "LoginItemPhone")

        // 圆角
        ViewUtil.showLargeRadius(view: btLogin)
    }

    /// 登录按钮点击回调方法
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onLoginClick(_ sender: UIButton) {
        print("LoginController onLoginClick")

        //获取用户名
        let username = tfUsername.text!.trim()!

        if username.isEmpty {
            ToastUtil.short("请输入用户名！")
            return
        }

        var isPhone = false
        if username.isPhone() {
            isPhone = true
        } else if username.isEmail() {
            isPhone = false
        } else {
            //如果用户名 不是手机号 也不是 邮箱
            ToastUtil.short("用户名格式不正确！")
        }

        //获取密码
        let password = tfPassword.text!.trim()!

        if password.isEmpty {
            ToastUtil.short("请输入密码！")
            return
        }

        guard password.isPassword() else {
            ToastUtil.short(ERROR_PASSWORD_FORMAT)
            return
        }

        if isPhone {
            login(phone: username, password: password)
        } else {
            login(email: username, password: password)
        }
    }
}
