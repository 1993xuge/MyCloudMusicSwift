//
//  ViewExtend.swift
//  MyCloudMusicSwift
//  对UIView的扩展类，扩展设置边框的方法
//
//  Created by wangyixu on 2020/1/8.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

// MARK: - 这里使用了Swift的扩展语法
extension UIView {
    func showColorPrimaryBorder() {
        
        //边框为1
        self.layer.borderWidth = CGFloat(SIZE_BORDER)
        
        //边框颜色
//        self.layer.borderColor = UIColor(red: 212 / 255, green: 0, blue: 0, alpha: 1.0).cgColor
//        self.layer.borderColor = UIColor(hex: COLOR_PRIMARY).cgColor
        self.layer.borderColor = UIColor(named: "ColorPrimary")?.cgColor
    }
}
