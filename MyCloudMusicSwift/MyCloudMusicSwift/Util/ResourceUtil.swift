//
//  ResourceUtil.swift
//  MyCloudMusicSwift
//  资源工具类
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

class ResourceUtil {

    /// 将相对路径的资源转为绝对路径
    ///
    /// - Parameter uri: <#uri description#>
    /// - Returns: <#return value description#>
    static func resourceUri(_ uri: String) -> String {
        return "\(RESOURCE_ENDPOINT)/\(uri)"
    }
}
