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
        
        navigationItem.title="找回密码"
        
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
    }
}
