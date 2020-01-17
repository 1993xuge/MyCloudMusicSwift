//
//  CommentController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/17.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class CommentController: BaseTitleController {
    
    /// 歌单Id
    var sheet_id:String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - 启动方法
extension CommentController {
    /// 启动方法
    ///
    /// - Returns: <#return value description#>
    static func start(_ navigationController: UINavigationController, sheet: String) {
        //创建控制器
        let controller = navigationController.storyboard!.instantiateViewController(withIdentifier: "Comment") as! CommentController

        //传递参数
        controller.sheet_id = sheet

        //将控制器压入导航控制器
        navigationController.pushViewController(controller, animated: true)
    }
}
