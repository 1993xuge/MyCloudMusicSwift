//
//  ToastUtil.swift
//  MyCloudMusicSwift
//  提示；加载等待工具类
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class ToastUtil{
    
    private static var hud:MBProgressHUD?
    
    /// 显示一个短时间（1秒钟）的提示
    ///
    /// - Parameter message: 需要显示的消息
    static func short(_ message:String) {
        
        // 创建 一个 MBProgressHUD
        let hud = MBProgressHUD.showAdded(to: AppDelegate.shared.window!.rootViewController!.view, animated: true)
        
        // 只显示文字
        hud.mode = .text
        
        // 小矩形的背景颜色
        hud.bezelView.color = UIColor.black
        
        // 设置细节文本 显示的内容
        hud.detailsLabel.text = message
        
        // 设置 细节文本 的颜色
        hud.detailsLabel.textColor = UIColor.white
        
        // 1s后， 自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    /// 显示一个加载对话框
    ///
    /// - Parameter message: 需要显示的消息
    static func showLoading(_ message:String) {
        
        // 创建 一个 MBProgressHUD
        hud = MBProgressHUD.showAdded(to: AppDelegate.shared.window!.rootViewController!.view, animated: true)
        
        // 设置 菊花的颜色
        hud!.activityIndicatorColor = UIColor.white
        
        // 设置背景 模糊
        hud!.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        
        // 设置 背景为半透明
        //UIColor(white: 0.0：表示创建一个黑色
        //0.1:表示黑色有透明效果，0：完全透明；1：完全不透明（黑色）
        hud!.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        
        // 小矩形的背景颜色
        hud!.bezelView.color = UIColor.black
        
        // 设置细节文本 显示的内容
        hud!.detailsLabel.text = message
        
        // 设置 细节文本 的颜色
        hud!.detailsLabel.textColor = UIColor.white
        
        hud!.show(animated: true)
        
    }
    
    /// 显示一个加载对话框；使用默认文字
    static func showLoading() {
        showLoading("拼命加载中.")
    }
    
    /// 隐藏加载提示对话框
    static func hideLoading() {
        if let hud = hud{
            hud.hide(animated: true)
            ToastUtil.hud = nil
        }
    }
}
