//
//  PreferenceUtil.swift
//  MyCloudMusicSwift
//  偏好设置工具类；是否登录了，是否显示引导界面；用户Id
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

class PreferenceUtil {

    /// 是否显示引导界面
    ///
    /// - Returns: return true:表示要显示；false:表示不显示
    static func isShowGuide() -> Bool {

        let isShowGuide = UserDefaults.standard.bool(forKey: KEY_GUIDE)
        return !isShowGuide
    }

    /// 设置是否显示引导界面
    ///
    /// - Parameter data: true:不显示；false:显示
    static func setShowGuide(_ data: Bool) {
        UserDefaults.standard.set(data, forKey: KEY_GUIDE)
    }

    /// 是否显示引导界面常用key, 表示 是否 显示过引导界面
    private static let KEY_GUIDE = "KEY_GUIDE"
}
