//
//  BannerGuideController.swift
//  MyCloudMusicSwift
//  扩展引导界面轮播图的数据源和代理
//
//  Created by wangyixu on 2020/1/9.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

// MARK: - 初始化 轮播 组件
extension GuideController {
    func initBannerView() {
        // 设置 轮播数据源
        bannerView.dataSource = self
        // 设置 代理
        bannerView.delegate = self

        let defaultImage = UIImage(named: IMAGE_PLACE_HOLDER)
        // 设置 图片为空的图片，其实就是
        bannerView.emptyImage = defaultImage
        // 占位图
        bannerView.placeholderImage = defaultImage

        // 显示图片的时候 调用的方法
        bannerView.bannerViewSelectorString = "sd_setImageWithURL:placeholderImage:"

        // 指示器 默认颜色
        bannerView.pageControlNormalColor = UIColor(hex: COLOR_LIGHT_GREY)
        // 指示器 选中的颜色
        bannerView.pageControlHighlightColor = UIColor(hex: COLOR_PRIMARY)

        // 指示器 位置
        //        bannerView.pageControlAliment = .right

        // 禁用 自动滚动功能
        bannerView.autoScroll = false

        // 重新加载数据
        bannerView.reloadData()
    }
}

// MARK: - 实现轮播图数据源和代理方法
extension GuideController: YJBannerViewDataSource, YJBannerViewDelegate {

    /// banner数据源
    func bannerViewImages(_ bannerView: YJBannerView!) -> [Any]! {
        return ["Guide1", "Guide2", "Guide3", "Guide4", "Guide5"]
    }

    /// 自定义Cell
    /// 设置图片的缩放模式
    func bannerView(_ bannerView: YJBannerView!, customCell: UICollectionViewCell!, index: Int) -> UICollectionViewCell! {

        //将Cell转为YJBannerViewCell
        let cell = customCell as! YJBannerViewCell

        //按比例
        //从中心填充
        //多余的内容裁减掉
        cell.showImageViewContentMode = .scaleAspectFill

        return cell
    }

    /// banner点击方法
    func bannerView(_ bannerView: YJBannerView!, didSelectItemAt index: Int) {
        print("GuideController on banner view click:\(index)")
    }
}
