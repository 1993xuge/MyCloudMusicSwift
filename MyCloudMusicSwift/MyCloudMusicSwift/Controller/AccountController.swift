//
//  AccountController.swift
//  MyCloudMusicSwift
//  首页账号界面
//
//  Created by wangyixu on 2020/1/13.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class AccountController: BaseCommonController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// 退出按钮点击事件
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onLogoutClick(_ sender: UIButton) {
        AppDelegate.shared.logout()
    }
}
