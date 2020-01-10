//
//  RegisterController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class RegisterController: BaseController {

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
        
        let nickName = tfNickname.text!.trim()!
        
        if nickName.isEmpty {
            ToastUtil.short("请输入昵称！")
            return
        }
        
        guard nickName.isNickName() else {
            ToastUtil.short("昵称长度 不对")
            return
        }
       
        //获取到手机号
        let phone=tfPhone.text!.trim()!
        
        if phone.isEmpty {
            ToastUtil.short("请输入手机号！")
            return
        }
        
        guard phone.isPhone() else {
            ToastUtil.short("手机号格式不正确！")
            return
        }
    }
    
    /// 注册协议点击
    @IBAction func onAgreementClick(_ sender: UIButton) {
         print("RegisterController onAgreementClick")
    }
}
