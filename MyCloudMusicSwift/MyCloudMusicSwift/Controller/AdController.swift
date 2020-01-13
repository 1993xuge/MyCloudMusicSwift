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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()

        ViewUtil.showRadius(btSkipAd, 15)
    }

    /// 点击了广告
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onAdClick(_ sender: UIButton) {
        print("AdController onAdClick")
    }

    /// 点击了跳过广告按钮
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func onSkipAdClick(_ sender: UIButton) {
        print("AdController onSkipAdClick")
    }
}
