//
//  StringExtend.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/10.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

extension String {

    /// 是否符合手机号格式
    ///
    /// - Returns: 是否是 手机号
    public func isPhone() -> Bool {

        // 使用 谓词
        let predicate = NSPredicate(format: "SELF MATCHES %@", REGX_PHONE)
        return predicate.evaluate(with: self)
    }

    /// 去除字符串首尾的空格和换行
    ///
    /// - Returns: 结果 字符串
    func trim() -> String? {
        let whitespce = NSCharacterSet.whitespacesAndNewlines
        return trimmingCharacters(in: whitespce)
    }

    /// 是否符合昵称规范（2~15位）
    ///
    /// - Returns: true, 昵称 符合规则
    func isNickName() -> Bool {
        if self.count >= 2 && count <= 15 {
            return true
        }
        return false
    }

    /// 是否符合邮箱格式
    ///
    /// - Returns: true，符合邮箱规则
    func isEmail() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", REGX_EMAIL)
        return predicate.evaluate(with: self)
    }

    /// 是否符合密码格式
    ///
    /// - Returns: true， 密码符合规则
    func isPassword() -> Bool {
        return count >= 6 && count <= 15
    }
}
