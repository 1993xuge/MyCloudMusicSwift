//
//  ViewUtil.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/8.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class ViewUtil {
    /// 设置 大圆角
    ///
    /// - Parameter view: 要设置的View
    static func showLargeRadius(view:UIView) {
        view.layer.cornerRadius = CGFloat(SIZE_LARGE_RADIUS)
        
        //裁剪多余的内容
        //例如：给ImageView设置了圆角，如果不裁剪多余的内容，就不会生效
        view.clipsToBounds = true
    }
}
