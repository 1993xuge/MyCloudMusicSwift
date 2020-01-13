//
//  AdController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/13.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class AdController: BaseController {

    /// 跳过广告按钮
    @IBOutlet weak var btSkipAd: UIButton!

    /// 异步任务
    var task: DispatchWorkItem!

    /// 广告地址
    /// 只有点击了启动页后面的广告才有值
    var adUri: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()

        ViewUtil.showRadius(btSkipAd, 15)
    }

    // 状态栏 颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // 内容为白色
        return UIStatusBarStyle.lightContent
    }

    override func initDatas() {
        super.initDatas()

        //TODO 设置广告
        //如果通过服务端获取到广告图片
        //可以在这设置到ImageView

        //创建一个闭包
        //如果要取消一个延时就要使用这种方式创建
        task = DispatchWorkItem {
            self.next()
        }

        //添加任务到队列
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: task)
    }

    /// 进入首页
    func next() {
        print("AdController next")

        AppDelegate.shared.toHome(adUri)
    }

    /// 点击了广告
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onAdClick(_ sender: UIButton) {
        print("AdController onAdClick")

        //正常情况，该界面的广告来自一个接口
        //他应该包含显示的图片，点击跳转的网址
        //这里就写死

        //由于当前界面和首页的导航控制器不是同一个
        //所以不能再这里启动显示广告的页面
        //而应该在显示首页后，在显示广告页面
        //因为我们希望用户看完广告，返回的是首页，而不是广告页面

        adUri = "http://www.ixuea.com"

        onSkipAdClick(sender)
    }

    /// 点击了跳过广告按钮
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onSkipAdClick(_ sender: UIButton) {
        print("AdController onSkipAdClick")

        //取消延时
        task.cancel()

        //马上进入下一步操作
        next()
    }
}
