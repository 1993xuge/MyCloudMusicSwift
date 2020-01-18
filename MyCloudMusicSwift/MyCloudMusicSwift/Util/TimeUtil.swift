//
//  TimeUtil.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/18.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class TimeUtil: Any {
    
    /// 将秒转为分秒格式
    ///
    /// - Parameter value: <#value description#>
    /// - Returns: 格式为：10:20
    static func second2MinuteAndSecond(_ value: Float) -> String {
        let minute = Int(value / 60)
        let second = Int(value) % 60

        return String(format: "%02d:%02d", minute, second)
    }
}
