//
//  RegisterController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

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

        ViewUtil.showLargeRadius(view: btRegister)
        
        //设置左侧显示的图标
        tfNickname.showLeftIcon(name: "LoginItemPhone")
        tfPhone.showLeftIcon(name: "LoginItemPhone")
        tfEmail.showLeftIcon(name: "LoginItemPhone")
        tfPassword.showLeftIcon(name: "LoginItemPhone")
        tfConfirmPassword.showLeftIcon(name: "LoginItemPhone")
        
        // Do any additional setup after loading the view.
    }

    //MARK: - 点击事件
    /// 注册按钮点击事件
    @IBAction func onRegisterClick(_ sender: UIButton) {
         print("RegisterController onRegisterClick")
    }
    
    /// 注册协议点击
    @IBAction func onAgreementClick(_ sender: UIButton) {
         print("RegisterController onAgreementClick")
    }
}
