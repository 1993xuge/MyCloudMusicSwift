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
enum Service {
    case sheetDetail(id: String)
    case sheets
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
        default:
            return ""
        }
    }

    /// 请求方式
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        //不传递任何参数
        return .requestPlain
    }

    var headers: [String: String]? {
        return nil
    }

    /// 返回测试相关的路径
    var sampleData: Data {
        return Data()
    }
}

