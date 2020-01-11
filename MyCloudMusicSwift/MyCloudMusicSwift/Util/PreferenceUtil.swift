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

    // MARK: - 用户相关
    /// 保存用户Id
    ///
    /// - Parameter data: <#data description#>
    static func setUserId(_ data: String) {
        UserDefaults.standard.set(data, forKey: KEY_USER_ID)
    }

    /// 获取用户Id
    ///
    /// - Returns: <#return value description#>
    static func userId() -> String? {
        return UserDefaults.standard.string(forKey: KEY_USER_ID)
    }

    /// 保存用户会话标识
    ///
    /// - Parameter data: <#data description#>
    static func setUserToken(_ data: String) {
        UserDefaults.standard.set(data, forKey: KEY_USER_TOKEN)
    }

    /// 获取用户会话标识
    ///
    /// - Returns: <#return value description#>
    static func userToken() -> String {
        return UserDefaults.standard.string(forKey: KEY_USER_TOKEN)!
    }

    static func isLogin() -> Bool {
        if let _ = userId() {
            return true
        } else {
            return false
        }
    }

    /// 是否显示引导界面常用key, 表示 是否 显示过引导界面
    private static let KEY_GUIDE = "KEY_GUIDE"

    /// 用户Id常量key
    private static let KEY_USER_ID = "KEY_USER_ID"

    /// 用户标识常量key
    private static let KEY_USER_TOKEN = "KEY_USER_TOKEN"
}
