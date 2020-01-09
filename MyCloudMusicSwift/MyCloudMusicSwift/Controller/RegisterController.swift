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
        ToastUtil.short("注册")
        
        var nickName = tfNickname.text!
        
        //去掉字符串中前后的空格
        let whiteSpace = NSCharacterSet.whitespacesAndNewlines
        
        nickName = nickName.trimmingCharacters(in: whiteSpace)
        
        //判断是否输入了昵称
        if nickName.isEmpty{
            ToastUtil.short("请输入昵称！")
            return
        }
        
        //判断昵称格式
        if nickName.count<2 || nickName.count>15 {
            ToastUtil.short("昵称长度不对！")
            return
        }
        
        //获取到手机号
        var phone=tfPhone.text!
        
        //去掉前后的空白字符
        phone=phone.trimmingCharacters(in: whiteSpace)
        if phone.isEmpty {
            ToastUtil.short("请输入手机号！")
            return
        }
        
    }
    
    /// 注册协议点击
    @IBAction func onAgreementClick(_ sender: UIButton) {
         print("RegisterController onAgreementClick")
    }
}
