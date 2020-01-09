//
//  GuideController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/7.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class GuideController: UIViewController {

    // MARK: - 字段
    /// 顶部的轮播图
    @IBOutlet weak var bannerView: YJBannerView!
    // 底部容器
    @IBOutlet weak var vmFooterContainer: UIView!

    /// 登录注册按钮
    @IBOutlet weak var btLoginOrRegister: UIButton!

    /// 立即体验按钮
    @IBOutlet weak var btEnter: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化轮播图组件
        initBannerView()
    }

    // 当 布局 完成后
    override func viewDidLayoutSubviews() {

        //底部按钮容器，高度100;按钮宽130,高40;两个按钮平分屏幕
        //按钮在容器中垂直居中

        //按钮垂直位置,y
        let buttonY = (vmFooterContainer.frame.size.height - CGFloat(SIZE_BUTTON_ENTER_HEIGHT)) / 2

        // 登录注册按钮，x
        let btnLoginOrRegisterX = (vmFooterContainer.frame.size.width - (CGFloat(SIZE_BUTTON_ENTER_WIDTH) * 2)) / 3

        // 设置登录/注册按钮位置和大小
        btLoginOrRegister.frame = CGRect(x: btnLoginOrRegisterX, y: buttonY, width: CGFloat(SIZE_BUTTON_ENTER_WIDTH), height: CGFloat(SIZE_BUTTON_ENTER_HEIGHT))

        // 设置登录/注册按钮位置和大小
        let btnEnterX = btnLoginOrRegisterX * 2 + CGFloat(SIZE_BUTTON_ENTER_WIDTH)

        // 设置立即体验按钮位置和大小
        btEnter.frame = CGRect(x: btnEnterX, y: buttonY, width: CGFloat(SIZE_BUTTON_ENTER_WIDTH), height: CGFloat(SIZE_BUTTON_ENTER_HEIGHT))

        // 设置圆角
        ViewUtil.showLargeRadius(view: btLoginOrRegister)
        ViewUtil.showLargeRadius(view: btEnter)

        // 设置边框
        btEnter.showColorPrimaryBorder()
    }

    //MARK: - 事件
    /// 登录或注册按钮点击
    @IBAction func onLoginOrRegisterClick(_ sender: UIButton) {
        print("GuideController onLoginOrRegisterClick")

        // 调用它里面的方法显示登录/注册界面
        AppDelegate.shared.toLoginOrRegister()
    }

    /// 立即体验按钮点击
    @IBAction func onEnterClick(_ sender: UIButton) {
        print("GuideController onEnterClick")
        AppDelegate.shared.toHome()
    }
}
