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
    func setTitle(_ title:String) {
        navigationItem.title=title
    }
    
    /// 设置导航栏返回按钮颜色
    ///
    /// - Parameter color: <#color description#>
    func setNavigationBarTintColor(_ color:UIColor) {
        navigationController!.navigationBar.tintColor=color
    }
    
    /// 设置导航栏标题文本颜色
    ///
    /// - Parameter color: <#color description#>
    func setTitleTextColor(_ color:UIColor) {
        navigationController?.navigationBar.titleTextAttributes=[.foregroundColor:color]
    }
}
