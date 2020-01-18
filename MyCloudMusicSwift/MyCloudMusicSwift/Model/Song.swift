//
//  Song.swift
//  MyCloudMusicSwift
//  单曲
//
//  Created by wangyixu on 2020/1/15.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

//导入JSON解析框架
import HandyJSON

class Song: BaseModel {

    /// 标题
    var title: String!

    /// 封面图
    var banner: String!

    /// 音乐地址
    var uri: String!

    /// 点击数
    var clicks_count = 0

    /// 评论数
    var comments_count: Int = 0

    /// 歌词类型
    var style: LyricType!

    /// 歌词内容
    var lyric: String?

    /// 创建该音乐的人
    var user: User!

    /// 歌手
    var singer: User!
    
    // MARK: - 播放后才有值
    /// 时长
    var duration:Float = 0
    
    /// 播放进度
    var progress:Float = 0
}

/// 歌词类型
///
/// - lrc: LRC歌词
/// - ksc: KSC歌词
enum LyricType: Int, HandyJSONEnum {
    case lrc = 0
    case ksc = 10
}
