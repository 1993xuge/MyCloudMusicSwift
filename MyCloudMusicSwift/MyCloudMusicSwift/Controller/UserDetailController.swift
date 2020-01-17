//
//  UserDetailController.swift
//  MyCloudMusicSwift
//  用户详情界面
//
//  Created by wangyixu on 2020/1/17.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class UserDetailController: BaseTitleController {

    /// 用户Id
    var userId: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - 启动方法
extension UserDetailController {

    /// 根据用户Id获取用户详情
    ///
    /// - Parameters:
    ///   - navigationController: <#navigationController description#>
    ///   - userId: <#userId description#>
    static func start(_ navigationController: UINavigationController, userId: String) {
        //创建Controller
        let controller = navigationController.storyboard!.instantiateViewController(withIdentifier: "UserDetail") as! UserDetailController

        //传递参数
        controller.userId = userId

        //将控制器压入导航控制器
        navigationController.pushViewController(controller, animated: true)
    }
}

