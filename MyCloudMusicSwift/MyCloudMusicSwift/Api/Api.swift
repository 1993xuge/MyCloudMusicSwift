//
//  Api.swift
//  MyCloudMusicSwift
//  网络请求接口包装类
//  对外部提供一个和框架无关的接口
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

import HandyJSON
import RxSwift
import Moya

class Api {

    // 饿汉式 设计模式
    static let shared = Api()

    private let provider: MoyaProvider<Service>!

    private init() {

        var plugins: [PluginType] = []
        if DEBUG {
            //表示当前是调试模式
            //添加网络请求日志插件
            plugins.append(NetworkLoggerPlugin())
        }

        //网络请求加载对话框
        let networkActivityPlugin = NetworkActivityPlugin { (changeType, targetType) in

            //changeType类型是NetworkActivityChangeType
            //通过它能监听到开始请求和结束请求

            //targetType类型是TargetType
            //就是我们这里的service
            //通过它能判断是那个请求

            if changeType == .began {
                //开始请求
                let targetType = targetType as! Service
                switch targetType {
                case .sheetDetail, .login:
                    print("应该 显示 对话框")
                    // 对话框 在 后台 显示 有问题
                    ToastUtil.showLoading()
                default:
                    break
                }
            } else {
                //结束请求
                //请求结束这里可以不用 判断 请求 类型
                print("应该 结束 对话框")
                ToastUtil.hideLoading()
            }
        }
        plugins.append(networkActivityPlugin)

        provider = MoyaProvider<Service>(plugins: plugins)
    }

    /// 歌单列表
    ///
    /// - Returns: 可观察的结果
    func sheets() -> Observable<ListResponse<Sheet>?> {
        return provider
            .rx
            .request(.sheets)
            .asObservable()
            .mapString()
            .mapObject(ListResponse<Sheet>.self)
    }

    /// 歌单列表
    ///
    /// - Returns:  可观察的结果
    func sheetDetail(id: String) -> Observable<DetailResponse<Sheet>?> {
        return provider
            .rx
            .request(.sheetDetail(id: id))
            .asObservable()
            .mapString()
            .mapObject(DetailResponse<Sheet>.self)
    }

    /// 创建用户（注册）
    ///
    /// - Parameters:
    ///   - avatar: 头像
    ///   - nickname: 昵称
    ///   - phone: 手机号
    ///   - email: 邮箱
    ///   - password: 密码
    ///   - qq_id: qq第三方登录后的Id
    ///   - weibo_id: 微博第三方登录后的Id
    /// - Returns: <#return value description#>
    func createUser(avatar: String? = nil, nickname: String, phone: String, email: String, password: String, qq_id: String? = nil, weibo_id: String? = nil) -> Observable<DetailResponse<BaseModel>?> {

        return provider
            .rx
            .request(.createUser(avatar: avatar, nickname: nickname, phone: phone, email: email, password: password, qq_id: qq_id, weibo_id: weibo_id))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .mapString()
            .mapObject(DetailResponse<BaseModel>.self)
    }

    /// 登录
    ///
    /// - Parameters:
    ///   - phone: 手机号
    ///   - email: 邮件
    ///   - password: 密码
    ///   - qq_id: qq第三方登录后Id
    ///   - weibo_id: 微博第三方登录后Id
    /// - Returns: <#return value description#>
    func login(phone: String? = nil, email: String? = nil, password: String? = nil, qq_id: String? = nil, weibo_id: String? = nil) -> Observable<DetailResponse<Session>?> {
        return provider
            .rx
            .request(.login(phone: phone, email: email, password: password, qq_id: qq_id, weibo_id: weibo_id))
            .filterSuccessfulStatusCodes()
            .mapString()
            .asObservable()
            .mapObject(DetailResponse<Session>.self)
    }

    /// 重置密码
    ///
    /// - Parameters:
    ///   - phone: 手机号
    ///   - email: 邮箱
    ///   - code: 验证码
    ///   - password: 新密码
    /// - Returns: <#return value description#>
    func resetPassword(phone: String?, email: String?, code: String, password: String) -> Observable<DetailResponse<BaseModel>?> {
        return provider.rx
            .request(.resetPassword(phone: phone, email: email, code: code, password: password))
            .filterSuccessfulStatusCodes()
            .mapString()
            .asObservable()
            .mapObject(DetailResponse<BaseModel>.self)
    }
}
