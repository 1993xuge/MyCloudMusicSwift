//
//  DiscoveryController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/13.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class DiscoveryController: BaseCommonController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        navigationItem.title = "发现"
    }

    override func initListeners() {
        super.initListeners()

        print("initListeners")
        //添加一个通知监听

        //当用户点击了启动界面的广告
        //就会调用当前界面的onAdClick方法
        NotificationCenter.default.addObserver(self, selector: #selector(onAdClick(notification:)), name: NSNotification.Name(rawValue: AD_CLICK), object: nil)
    }

    /// 当用户点击了启动界面的广告后回调
    ///
    /// - Parameter notification: <#notification description#>
    @objc func onAdClick(notification: NSNotification) {
        let adUri = notification.userInfo!["adUri"] as! String
        print("DiscoveryController onAdClick:\(adUri)")

        let controller = navigationController!.storyboard!.instantiateViewController(withIdentifier: "WEB") as! WebController

        // 设置参数
        controller.title = "活动详情"
        controller.uri = adUri

        //将控制器压入导航控制器
        navigationController?.pushViewController(controller, animated: true)
    }
}
