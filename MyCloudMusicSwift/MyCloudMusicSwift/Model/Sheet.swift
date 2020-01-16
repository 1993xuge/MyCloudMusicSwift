//
//  Sheet.swift
//  MyCloudMusicSwift
//  歌单模型
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

//导入JSON解析框架
import HandyJSON

class Sheet: HandyJSON {

    /// 歌单Id
    var id: String!

    /// 标题
    var title: String!

    /// 封面
    var banner: String?

    /// 描述
    var description: String?

    /// 点击数
    var clicks_count: Int = 0

    /// 收藏数
    var collections_count = 0

    /// 评论数
    var comments_count = 0

    /// 音乐数
    var songs_count = 0

    /// 歌单创建者
    var user: User!

    /// 歌曲
    var songs: [Song]?

    /// 是否收藏；有值就表示收藏了
    var collection_id: Int?

    //因为HandyJSON解析框架要求有一个init方法
    required init() { }

    /// 是否收藏
    ///
    func isCollection() -> Bool {
        return collection_id == nil ? false : true
    }
}
