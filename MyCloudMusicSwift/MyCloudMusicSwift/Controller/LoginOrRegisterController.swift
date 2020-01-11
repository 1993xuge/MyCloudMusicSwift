//
//  LoginOrRegisterController.swift
//  MyCloudMusicSwift
//  登录/注册界面
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class LoginOrRegisterController: BaseController {

    // 登录
    @IBOutlet weak var btnLogin: UIButton!

    // 注册
    @IBOutlet weak var btnRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        super.initViews()
        // 设置 边框
        btnLogin.showColorPrimaryBorder()
        btnRegister.showColorPrimaryBorder()

        // 设置圆角
        ViewUtil.showLargeRadius(view: btnLogin)
        ViewUtil.showLargeRadius(view: btnRegister)
    }

    /// 按下
    ///
    /// - Parameter sender: 按下的btn
    @IBAction func touchDown(_ sender: UIButton) {
        // 设置 按钮 按下的颜色
        sender.backgroundColor = UIColor(hex: COLOR_PRIMARY)
    }


    /// 抬起，在按钮内 抬起
    ///
    /// - Parameter sender: 抬起的btn
    @IBAction func touchUp(_ sender: UIButton) {
        // 设置 按钮 抬起的颜色
        sender.backgroundColor = UIColor.white

        if sender == btnLogin {
            // 登录
            toLogin()
        } else {
            // 注册
            toRegister()
        }
    }

    /// 抬起，在按钮外抬起
    ///
    /// - Parameter sender: 抬起的btn
    @IBAction func touchUpOutside(_ sender: UIButton) {
        touchUp(sender)
    }

    func toLogin() {
        print("LoginOrRegisterController toLogin")
//        ToastUtil.short("去登陆")
//        ToastUtil.showLoading()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//            // 延迟了3s后。
//            ToastUtil.hideLoading()
//        })

//        testRequest()
//        testRequestError()
//        testRequestWithRx()
//        testRequestWithRxAndJson()
//        testRequestWithRxAndJsonAndMap()
//        testRequestWithRxAndJsonAndMapAndBase()
        testRequestWithRxAndJsonAndMapAndBaseAndList()
    }

    func testRequestWithRxAndJsonAndMapAndBaseAndList() {
        let provider = MoyaProvider<Service>()

        provider
            .rx
            .request(.sheets)
        // 过滤 错误的状态码，比如404。当接收到 错误的响应码时，将其放入到 Error中处理。如果没有这个，那么将会当成Success处理
        .filterSuccessfulStatusCodes()
            .asObservable()
            .mapString()
            .mapObject(ListResponse<Sheet>.self)
            .subscribe(
                onNext: { data in
                    // data 是 DetailResponse<Sheet>?
                    print("RegisterController request sheet detail success:\(data?.data?.count)")
                }, onError: { error in
                    // eerror : Error
                    print("RegisterController request sheet detail faield:\(error)")
                }, onCompleted: {
                    // (() -> Void)?
                    print("onCompleted")
                }) {
                // (() -> Void)?
                print("OnDisposed")
        }
    }

    func testRequestWithRxAndJsonAndMapAndBase() {
        let provider = MoyaProvider<Service>()

        provider.rx.request(.sheetDetail(id: "1"))
            .asObservable()
            .mapString()
            .mapObject(DetailResponse<Sheet>.self)
            .subscribe(
                onNext: { data in
                    // data 是 DetailResponse<Sheet>?
                    print("RegisterController request sheet detail success:\(data?.data?.title)")
                }, onError: { error in
                    // eerror : Error
                    print("RegisterController request sheet detail faield:\(error)")
                }, onCompleted: {
                    // (() -> Void)?
                    print("onCompleted")
                }) {
                // (() -> Void)?
                print("OnDisposed")
        }
    }

    func testRequestWithRxAndJsonAndMap() {
        let provider = MoyaProvider<Service>()

        provider
            .rx
            .request(.sheetDetail(id: "1"))
            .asObservable()
            .mapString()
            .mapObject(SheetWrapper.self)
            .subscribe { event in
                if let data = event.element {
                    print("RegiseterController request sheet detail success:\(data?.data.title)")
                }
        }
    }

    func testRequestWithRxAndJson() {
        let provider = MoyaProvider<Service>()
        provider
            .rx
            .request(.sheetDetail(id: "1"))
            .subscribe { event in
                //event类型是SingleEvent<Response>
                switch event {
                case let .success(response):
                    let data = response.data
                    let code = response.statusCode
                    // 将data转为 字符串
                    let dataString = String(data: data, encoding: .utf8)

                    //解析JSON为对象
                    let sheetWrapper = SheetWrapper.deserialize(from: dataString)

                    //解析完成了
                    print("RegisterController request sheet detail succes:\(sheetWrapper?.data.title)")

                case let .error(error):
                    print("RegisterController request sheet detail failed:\(error)")
                }
        }
    }

    func testRequestWithRx() {
        let provider = MoyaProvider<Service>()
        provider
            .rx
            .request(.sheetDetail(id: "1"))
            .subscribe { event in
                //event类型是SingleEvent<Response>
                switch event {
                case let .success(response):
                    let data = response.data
                    let code = response.statusCode
                    // 将data转为 字符串
                    let dataString = String(data: data, encoding: .utf8)
                    print("RegisterController request sheet detail success:\(code),\(dataString)")
                case let .error(error):
                    print("RegisterController request sheet detail failed:\(error)")
                }
        }
    }

    func testRequestError() {
//        let provider = MoyaProvider<Service>()

        // 添加 日志 c插件
//        let provider = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin()])


        // 添加 请求对话框 插件
        let networkActivityPlugin = NetworkActivityPlugin { (changeType, targetType) in
            //changeType他的类似是NetworkActivityChangeType

            //targetType的类型是TargetType
            //就是我们项目中的service枚举
            if changeType == .began {
                // 开始  请求
                print("RegisterControler began request:\(targetType.path)")
//                ToastUtil.showLoading()
            } else {
                // 结束请求
                print("RegisterController end request:\(targetType.path)")
//                ToastUtil.hideLoading()
            }
        }
        let provider = MoyaProvider<Service>(plugins: [networkActivityPlugin])

        provider.request(.sheetDetail(id: "1")) { event in
            switch event {
            case let .success(response):
                // 请求成功
                let data = response.data
                let code = response.statusCode

                // 将data转为 字符串
                let dataString = String(data: data, encoding: .utf8)
                print("RegisterController request sheet detail success:\(code),\(dataString)")

            case let .failure(error):
                print("RegisterController request sheet detail failed:\(error)")

                let error = error as! MoyaError
                switch error {
                case .imageMapping(let response):
                    print("图片解析错误")
                case .jsonMapping(let response):
                    print("JSON解析错误")
                case .statusCode(let response):
                    print("状态错误")
                case .stringMapping(let response):
                    print("字符串映射错误")

                case .underlying(let nsError as NSError, let response):
                    print("这里将错误转为了NSError")
                    switch nsError.code {
                    case NSURLErrorNotConnectedToInternet:
                        print("网络不太好，请稍后再试！")
                    case NSURLErrorTimedOut:
                        print("连接超时，请稍后再试！")
                    default:
                        print("未知错误，请稍后再试！")
                    }

                case .objectMapping(_, _):
                    print("对象解码错误")
                case .encodableMapping(_):
                    print("对象编码错误")
                case .requestMapping(_):
                    print("请求映射错误")
                case .parameterEncoding(_):
                    print("参数编码错误")

                default:
                    print("未知错误")
                }
            }
        }
    }

    func testRequest() {
        let provider = MoyaProvider<Service>()

        provider.request(.sheetDetail(id: "1000000")) { result in
            //result类型是Result<Response,MoyaError>

            switch result {
            case let .success(response):
                // 请求成功
                let data = response.data
                let code = response.statusCode

                //将data转为字符串
                let dataString = String(data: data, encoding: .utf8)

                print("RegisterController request sheet detail success:\(code),\(dataString)")
            case let .failure(error):
                // 请求失败
                print("RegisterController request sheet detail failed:\(error)")
            }
        }
    }

    func toRegister() {
        print("LoginOrRegisterController toRegister ")

        let controller = storyboard!.instantiateViewController(withIdentifier: "Register")

        // 将 控制器 要入到 导航控制器
        navigationController?.pushViewController(controller, animated: true)
    }

//MARK: - 第三方登录

/// 微信登录
///
/// - Parameter sender: <#sender description#>
    @IBAction func onWechatLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onWechatLoginClick")
    }

/// QQ登录按钮点击
///
/// - Parameter sender: <#sender description#>
    @IBAction func onQQLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onQQLoginClick")
    }

/// 微博登录按钮点击
///
/// - Parameter sender: <#sender description#>
    @IBAction func onWeiboLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onWeiboLoginClick")
    }

/// 网易邮箱登录按钮点击
///
/// - Parameter sender: <#sender description#>
    @IBAction func onNeteaseLoginClick(_ sender: UIButton) {
        print("LoginOrRegisterController onNeteaseLoginClick")
    }
}
