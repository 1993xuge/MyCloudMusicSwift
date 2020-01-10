//
//  FileUtil.swift
//  MyCloudMusicSwift
//  文件相关工具类
//
//  Created by wangyixu on 2020/1/10.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

class FileUtil {

    /// 文件大小格式化
    ///
    /// - Parameter data: 文件大小；单位byte
    /// - Returns: 格式化的文件大小；例如：1.22M
    static func formatFileSize(_ data: Int) -> String {
        if data <= 0 {
            return "0K"
        }

        let size = Double(data)

        let kiloByte = size / 1024

        if kiloByte < 1 && kiloByte > 0 {
            // 小于1K，那么 以Byte为单位
            return String(format: "%.2fByte", size)
        }

        let megaByte = kiloByte / 1024
        if megaByte < 1 {
            // 小于 1M, 那么 以 K为单位
            return String(format: "%.2fK", kiloByte)
        }

        let gigaByte = megaByte / 1024
        if gigaByte < 1 {
            // 小于 1G, 那么 以 M为单位
            return String(format: "%.2fM", megaByte)
        }

        let teraByte = gigaByte / 1024
        if teraByte < 1 {
            //不足1T
            return String(format: "%.2fG", gigaByte)
        }

        return String(format: "%.2fT", teraByte)
    }
}
