//
//  BaseCommonController.swift
//  MyCloudMusicSwift
//  通用的业务控制器
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit
import RxSwift

class BaseCommonController: BaseController {

    //负责对象销毁
    //这个功能类似NotificationCenter的removeObserver
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
