//
//  Service.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/10.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation
import Moya

/// 定义项目中的所有接口
///
/// - sheetDetail: 歌单详情
/// - sheets: 歌单列表
/// - createUser: 创建用户
enum Service {
    case sheetDetail(id: String)
    case sheets
    case createUser(avatar: String?, nickname: String, phone: String, email: String, password: String, qq_id: String?, weibo_id: String?)
    case login(phone: String?, email: String?, password: String?, qq_id: String?, weibo_id: String?)
}

// MARK: - 实现TargetType协议
extension Service: TargetType {

    /// 返回网址
    var baseURL: URL {
        return URL(string: ENDPOINT)!
    }

    /// 返回 每个请求的路径
    var path: String {
        switch self {
        case .sheets:
            return "/v1/sheets.json"
        case .sheetDetail(let id):
            return "/v1/sheets/\(id).json"
        case .createUser:
            return "/v1/users"
        case .login:
            return "/v1/sessions"
        default:
            return ""
        }
    }

    /// 请求方式
    var method: Moya.Method {
        switch self {
        case .createUser, .login:
            return .post

        default:
            return .get
        }
    }

    var task: Task {
        //不传递任何参数

        switch self {
        case .createUser(let avatar, let nickname, let phone, let email, let password, let qq_id, let weibo_id):
            return .requestParameters(parameters: ["avatar": avatar, "nickname": nickname, "phone": phone, "email": email, "password": password, "qq_id": qq_id, "weibo_id": weibo_id], encoding: JSONEncoding.default)
        case .login(let phone, let email, let password, let qq_id, let weibo_id):

//            return .requestParameters(parameters: ["phone": phone, "email": email, "password": password, "qq_id": qq_id, "weibo_id": weibo_id], encoding: JSONEncoding.default)
            return HttpUtil.jsonRequestParamters(["phone": phone, "email": email, "password": password, "qq_id": qq_id, "weibo_id": weibo_id])
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }

/// 返回测试相关的路径
    var sampleData: Data {
        return Data()
    }
}

