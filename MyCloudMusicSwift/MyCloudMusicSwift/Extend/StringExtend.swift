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
}
