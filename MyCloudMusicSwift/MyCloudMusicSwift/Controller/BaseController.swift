//
//  BaseController.swift
//  MyCloudMusicSwift
//  所有控制器通用父类
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        initDatas()
        initListeners()
    }
    
    /// 初始化控件
    func initViews() {
        
    }
    
    /// 初始化数据
    func initDatas() {
        
    }
    
    /// 初始化监听器
    func initListeners()  {
        
    }
}
