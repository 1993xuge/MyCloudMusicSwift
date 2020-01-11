//
//  HttpUtil.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

class HttpUtil {

    static func handlerRequest(baseResponse: BaseResponse? = nil, error: Error? = nil) {
        print("HttpUtil handlerRequest:\(baseResponse),\(error)")

        if let error = error as? MoyaError {
            //有错误
            //error类似就是Moya.MoayError

            switch error {
            case .imageMapping(let response):
                print("HttpUtil handlerRequest imageMapping:\(response)")

            case .stringMapping(let response):
                ToastUtil.short("响应转为字符串错误，请稍后再试！")

            case .statusCode(let response):
                //响应码
                let code = response.statusCode

                switch code {
                case 401:

                    AppDelegate.shared.logout()
                    //弹出提示
                    ToastUtil.short("登录信息过期，请重新登录！")
                case 403:
                    ToastUtil.short("你没有权限访问！")
                case 404:
                    ToastUtil.short("你访问的内容不存在！")
                case 500...599:
                    ToastUtil.short("服务器错误，请稍后再试！")
                default:
                    //                    ToastUtil.short("未知错误，请求稍后再试！")
                    HttpUtil.showUnknowError()
                }

            case .underlying(let nsError as NSError, _):
                switch nsError.code {
                case NSURLErrorNotConnectedToInternet:
                    ToastUtil.short("网络好像不太好，请求稍后再试！")
                case NSURLErrorTimedOut:
                    ToastUtil.short("连接超时，请稍后再试！")
                default:
                    //                    ToastUtil.short("未知错误，请稍后再试！")
                    HttpUtil.showUnknowError()
                }

            case .requestMapping:
                ToastUtil.short("请求映射错误，请稍后再试！")

            case .objectMapping(_, _):
                ToastUtil.short("对象映射错误，请稍后再试！")
            case .parameterEncoding(_):
                ToastUtil.short("参数格式错误，请稍后再试！")

            default:
                print("HttpUtil handlerRequest other error")
            }
        } else {
            //业务错误
            if let baseResponse = baseResponse {
                if let message = baseResponse.message {
                    //有错误提示
                    ToastUtil.short(message)
                } else {
                    //没有错误提示
                    HttpUtil.showUnknowError()
                }
            } else {
                HttpUtil.showUnknowError()
            }
        }
    }

    /// 显示未知错误
    static func showUnknowError() {
        ToastUtil.short("未知错误，请稍后再试！")
    }
}
