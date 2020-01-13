//
//  BaseTitleController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class BaseTitleController: BaseCommonController {

    override func initViews() {
        super.initViews()

        //设置导航栏返回按钮颜色为黑色
        setNavigationBarTintColor(UIColor.black)
    }

    /// 设置标题
    ///
    /// - Parameter title: <#title description#>
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    /// 设置导航栏返回按钮颜色
    ///
    /// - Parameter color: <#color description#>
    func setNavigationBarTintColor(_ color: UIColor) {
        navigationController!.navigationBar.tintColor = color
    }

    /// 设置导航栏标题文本颜色
    ///
    /// - Parameter color: <#color description#>
    func setTitleTextColor(_ color: UIColor) {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
    }

    /// 是否隐藏导航栏
    ///
    /// - Returns: true:隐藏；false:显示（默认）
    func hideNavigationBar() -> Bool {
        return false
    }

    /// 视图即将可见
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("BaseTitleController viewWillAppear")

        if hideNavigationBar() {
            //隐藏导航栏
            navigationController!.setNavigationBarHidden(true, animated: true)
        }
    }

    /// 视图即将消失
    ///
    /// - Parameter animated: <#animated description#>
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("BaseTitleController viewWillDisappear")

        if hideNavigationBar() {
            //显示导航栏
            //因为其他界面可能不需要隐藏
            navigationController!.setNavigationBarHidden(false, animated: true)
        }
    }
}
