//
//  WebController.swift
//  MyCloudMusicSwift
//  通用的显示网页的界面
//
//  Created by wangyixu on 2020/1/13.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit
//导入WKWebView
import WebKit

class WebController: BaseController {

    /// WebView控件
    @IBOutlet weak var wv: WKWebView!

    /// 要显示的地址
    var uri: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()

        //设置UI代理
        wv.uiDelegate = self

        //导航代理
        wv.navigationDelegate = self
    }

    override func initDatas() {
        super.initDatas()

        let url = URL(string: uri)!

        //创建request
        let request = URLRequest(url: url)

        //使用WebView加载这个请求
        wv.load(request)
    }
}

// MARK: - WKUIDelegate代理
extension WebController: WKUIDelegate {

}

// MARK: - WKNavigationDelegate代理
extension WebController: WKNavigationDelegate {

}

// MARK: - 启动界面
extension WebController {
    
    /// 启动界面
    ///
    /// - Parameters:
    ///   - navigationController: 导航控制器
    ///   - title: 显示的标题
    ///   - uri: 显示的网址
    static func start(_ navigationController:UINavigationController, _ title:String,_ uri:String) {
        //创建控制器
        let controller = navigationController.storyboard?.instantiateViewController(withIdentifier: "Web") as! WebController
        
        //传递参数
        controller.title=title
        controller.uri=uri
        
        //将控制器压入导航控制器中
        navigationController.pushViewController(controller, animated: true)
    }
}


