//
//  BaseLoginController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

import RxSwift

class BaseLoginController: BaseController {
    
    //负责对象销毁
    //这个功能类似NotificationCenter的removeObserver
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 登录
    func login(phone: String? = nil, email: String? = nil, password: String? = nil, qq_id: String? = nil, weibo_id: String? = nil) {
        Api.shared.login(phone: phone, email: email, password: password).subscribeOnSuccess { data in
            if let data = data?.data {
                //登录成功
                print("RegisterController onRegisterClick login success:\(data.user)")
                
                //把登录成功的事件通知到AppDelegate
                AppDelegate.shared.onLogin(data)
            }
            }.disposed(by: disposeBag)
    }
}
