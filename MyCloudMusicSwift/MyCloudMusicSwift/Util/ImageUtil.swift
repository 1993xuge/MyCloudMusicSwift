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
}
