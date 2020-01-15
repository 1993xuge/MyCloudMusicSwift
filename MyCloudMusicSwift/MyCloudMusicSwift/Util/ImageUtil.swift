//
//  ImageUtil.swift
//  MyCloudMusicSwift
//  图片工具类
//
//  Created by wangyixu on 2020/1/15.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

class ImageUtil {

    /// 显示网络图片（相对地址）
    ///
    static func show(_ imageView: UIImageView, _ uri: String) {
        //将图片地址转为绝对地址
        let uri = ResourceUtil.resourceUri(uri)

        //创建URL
        let url = URL(string: uri)

        //占位图
        let placeHolderImage = UIImage(named: "PlaceHolder")

        //显示图片
        imageView.sd_setImage(with: url, placeholderImage: placeHolderImage, options: [], completed: nil)
    }
    
    /// 显示绝对路径图片
    ///
    /// - Parameters:
    ///   - imageView: <#imageView description#>
    ///   - uri: <#uri description#>
    static func showFull(_ imageView:UIImageView,_ uri:String) {
        //创建URL
        let url = URL(string: uri)
        
        //占位图
        let placeHolderImage=UIImage(named: "PlaceHolder")
        
        //显示图片
        imageView.sd_setImage(with: url, placeholderImage: placeHolderImage, options: [], completed: nil)
    }

    /// 显示头像
    ///
    /// - Parameters:
    ///   - imageView: <#imageView description#>
    ///   - uri: <#uri description#>
    static func showAvatar(_ imageView: UIImageView, _ uri: String?) {
        if let avatar = uri {
            //有头像
            if avatar.hasPrefix("http") {
                // http 开头
                //绝对路径
                showFull(imageView, avatar)
            } else {
                //相对路径
                show(imageView, avatar)
            }
        } else {
            //没有头像
            imageView.image = UIImage(named: "PlaceHolder")
        }
    }
}
