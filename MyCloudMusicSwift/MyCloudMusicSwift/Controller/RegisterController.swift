//
//  RegisterController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

import RxSwift

import Moya

class RegisterController: BaseController {
    
    //负责对象销毁
    //这个功能类似NotificationCenter的removeObserver
    let disposeBag=DisposeBag()

    /// 昵称控件
    @IBOutlet weak var tfNickname: UITextField!

    /// 手机号控件
    @IBOutlet weak var tfPhone: UITextField!

    /// 邮箱控件
    @IBOutlet weak var tfEmail: UITextField!

    /// 密码控件
    @IBOutlet weak var tfPassword: UITextField!

    /// 确认密码控件
    @IBOutlet weak var tfConfirmPassword: UITextField!

    /// 注册按钮
    @IBOutlet weak var btRegister: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()
        ViewUtil.showLargeRadius(view: btRegister)

        //设置左侧显示的图标
        tfNickname.showLeftIcon(name: "LoginItemPhone")
        tfPhone.showLeftIcon(name: "LoginItemPhone")
        tfEmail.showLeftIcon(name: "LoginItemPhone")
        tfPassword.showLeftIcon(name: "LoginItemPhone")
        tfConfirmPassword.showLeftIcon(name: "LoginItemPhone")
    }

    //MARK: - 点击事件
    /// 注册按钮点击事件
    @IBAction func onRegisterClick(_ sender: UIButton) {
        print("RegisterController onRegisterClick")

        // 检查 昵称
        let nickName = tfNickname.text!.trim()!
        if nickName.isEmpty {
            ToastUtil.short("请输入昵称！")
            return
        }
        guard nickName.isNickName() else {
            ToastUtil.short("昵称长度 不对")
            return
        }

        // 检查手机号
        let phone = tfPhone.text!.trim()!
        if phone.isEmpty {
            ToastUtil.short("请输入手机号！")
            return
        }
        guard phone.isPhone() else {
            ToastUtil.short("手机号格式不正确！")
            return
        }

        // 检查 邮箱
        let email = tfEmail.text!.trim()!
        if email.isEmpty {
            ToastUtil.short("请输入邮箱！")
            return
        }
        guard email.isEmail() else {
            ToastUtil.short("邮箱格式不正确！")
            return
        }

        // 检查密码
        let password = tfPassword.text!.trim()!
        if password.isEmpty {
            ToastUtil.short("请输入密码！")
            return
        }
        guard password.isPassword() else {
            ToastUtil.short("密码格式不正确！")
            return
        }

        // 检查确认密码
        let confirmPassword = tfConfirmPassword.text!.trim()!

        if confirmPassword.isEmpty {
            ToastUtil.short("请输入确认密码！")
            return
        }

        guard confirmPassword.isPassword() else {
            ToastUtil.short("确认密码格式不正确！")
            return
        }

        //判断确认密码和密码是否一样
        guard password == confirmPassword else {
            ToastUtil.short("两次密码不一致！")
            return
        }

        print("nickName = \(nickName)  phone = \(phone)  email = \(email)  password = \(password)")
        Api.shared.createUser(nickname: nickName, phone: phone, email: email, password: password)
            .subscribeOnSuccess { data in
                // DetailResponse<BaseModel>?
                if let data = data?.data {
                    //注册成功
                    //进行后续的处理

                    print("RegisterController onRegisterClick create user succes:\(data.id)")
                    
                    //注册成功后自动登录
                    self.login(phone: phone, email: email, password: password)
                    
                } else {
                    //注册失败
                    ToastUtil.short("注册失败，请稍后再试！")
                }
        }
    }
    
    /// 登录
    func login(phone:String?=nil,email:String?=nil,password:String?=nil,qq_id:String?=nil,weibo_id:String?=nil) {
        Api.shared.login(phone: phone, email: email, password: password).subscribeOnSuccess { data in
            if let data = data?.data {
                //登录成功
                print("RegisterController onRegisterClick login success:\(data.user)")
                
                //把登录成功的事件通知到AppDelegate
                AppDelegate.shared.onLogin()
            }
            }.disposed(by: disposeBag)
    }

    /// 注册协议点击
    @IBAction func onAgreementClick(_ sender: UIButton) {
        print("RegisterController onAgreementClick")
    }
}
