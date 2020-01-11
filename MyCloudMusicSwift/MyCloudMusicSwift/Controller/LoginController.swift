//
//  LoginController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class LoginController: BaseController {

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
    }
}
