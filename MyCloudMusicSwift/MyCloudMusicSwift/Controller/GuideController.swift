//
//  GuideController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/7.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class GuideController: UIViewController {

    // 底部容器
    @IBOutlet weak var vmFooterContainer: UIView!

    /// 登录注册按钮
    @IBOutlet weak var btLoginOrRegister: UIButton!

    /// 立即体验按钮
    @IBOutlet weak var btEnter: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // 当 布局 完成后
    override func viewDidLayoutSubviews() {

        // 获取当前view的frame
        // 也就是当前view的，x,y，width,height
//        let contentFrame = view.frame

        //底部按钮容器，高度100;按钮宽130,高40;两个按钮平分屏幕
        //按钮在容器中垂直居中

        //按钮垂直位置,y
        let buttonY = (vmFooterContainer.frame.size.height - 40) / 2

        // 登录注册按钮，x
        let btnLoginOrRegisterX = (vmFooterContainer.frame.size.width - 130 * 2) / 3

        // 设置登录/注册按钮位置和大小
        btLoginOrRegister.frame = CGRect(x: btnLoginOrRegisterX, y: buttonY, width: 130, height: 40)

        // 设置登录/注册按钮位置和大小
        let btnEnterX = btnLoginOrRegisterX * 2 + 130

        // 设置立即体验按钮位置和大小
        btEnter.frame = CGRect(x: btnEnterX, y: buttonY, width: 130, height: 40)

        // //登录/注册按钮圆角20
        
        btLoginOrRegister.layer.cornerRadius = 20
        btEnter.layer.cornerRadius = 20
        
        // 边框为1
        btEnter.layer.borderWidth = 1
        
        // 边框颜色
        // 参数为：rgb
        // 透明度：0：完全透明，1:完全不透明
        // 取值都是0~1，所以要除以255.0
        btEnter.layer.borderColor=UIColor(red: 212/255.0, green: 0, blue: 0, alpha: 1.0).cgColor
    }
}
