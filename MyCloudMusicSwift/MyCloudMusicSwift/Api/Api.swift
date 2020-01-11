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

    private let provider: MoyaProvider<Service>

    private init() {
        provider = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin()])
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
}
