//
//  HomeController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class HomeController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 TabBar高亮颜色
        tabBar.tintColor = UIColor(hex: COLOR_PRIMARY)
    }
    
}
