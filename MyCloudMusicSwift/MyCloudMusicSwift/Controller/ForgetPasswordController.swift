//
//  ForgetPasswordController.swift
//  MyCloudMusicSwift
//  找回密码界面
//
//  Created by wangyixu on 2020/1/12.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class ForgetPasswordController: BaseLoginController {

    /// 用户名
    @IBOutlet weak var tfUsername: UITextField!

    /// 发送验证码按钮
    @IBOutlet weak var btSendCode: UIButton!

    /// 验证码输入框
    @IBOutlet weak var tfCode: UITextField!

    /// 密码
    @IBOutlet weak var tfPassword: UITextField!

    /// 确认密码
    @IBOutlet weak var tfConfirmPassword: UITextField!

    /// 重置密码按钮
    @IBOutlet weak var btResetPassword: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()

        navigationItem.title = "找回密码"

        //按钮圆角
        ViewUtil.showLargeRadius(view: btResetPassword)
    }

    /// 发送验证码按钮点击事件
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onSendCodeClick(_ sender: UIButton) {
        print("ForgetPasswordController onSendCodeClick")

    }

    /// 重置密码按钮点击事件
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onResetPasswordClick(_ sender: UIButton) {
        print("ForgetPasswordController onResetPasswordClick")

        //获取用户名
        let username = tfUsername.text!.trim()!
        if username.isEmpty {
            ToastUtil.short("请输入用户名！")
            return
        }
        guard username.isPhone() || username.isEmail() else {
            ToastUtil.short("用户名格式不正确！")
            return
        }

        //获取验证码
        let code = tfCode.text!.trim()!
        if code.isEmpty {
            ToastUtil.short("请输入验证码！")
            return
        }
        guard code.isCode() else {
            ToastUtil.short("验证码格式不正确！")
            return
        }

        //获取密码
        let password = tfPassword.text!.trim()!
        if password.isEmpty {
            ToastUtil.short("请输入密码！")
            return
        }
        guard password.isPassword() else {
            ToastUtil.short("密码格式不正确！")
            return
        }

        //获取确认密码
        let confirmPassPassword = tfConfirmPassword.text!.trim()!

        if confirmPassPassword.isEmpty {
            ToastUtil.short("请输入确认密码！")
            return
        }

        guard confirmPassPassword.isPassword() else {
            ToastUtil.short("确认密码格式不正确！")
            return
        }

        //判断密码和确认密码是否一样
        guard password == confirmPassPassword else {
            ToastUtil.short("两次密码不一样！")
            return
        }

        //判断用户名是手机号还是邮箱
        var phone: String?
        var email: String?
        if username.isPhone() {
            phone = username
        } else if username.isEmail() {
            email = username
        }

        //企业级项目中，这些参数可能会加密
        //我们的服务端接口也是支持的
        //为了讲解课程难度
        //我们就不所有的接口加密
        //就只在订单那边接口实现加密
        Api.shared.resetPassword(phone: phone, email: email, code: code, password: password).subscribeOnSuccess { baseModel in
            // DetailResponse<BaseModel>?

            //重置成功
            print("ForgetPasswordController onResetPasswordClick success")

            //重置密码完成后
            //自动登录
            self.login(phone: phone, email: email, password: password)
        }.disposed(by: disposeBag)

    }
}
