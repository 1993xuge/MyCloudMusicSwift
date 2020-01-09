//
//  TextFieldExtend.swift
//  MyCloudMusicSwift
//  扩展TextField
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// 显示左侧图标
    ///
    /// - Parameter name: 图标名称
    func showLeftIcon(name:String) {
        // 设置 显示 图片
        
        leftView = UIImageView(image: UIImage(named: name))
        
        // 可以 给 left设置 宽高，来调整 leftView  与 内容的间距
        
        // . 语法，是 swift 自动 推断
        leftViewMode = .always
    }
}
