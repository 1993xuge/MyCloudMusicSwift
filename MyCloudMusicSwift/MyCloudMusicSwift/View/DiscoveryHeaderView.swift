//
//  DiscoveryHeaderView.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class DiscoveryHeaderView: UICollectionReusableView {

    static let NAME = "DiscoveryHeaderView"

    /// 轮播图
    @IBOutlet weak var bannerView: YJBannerView!

    /// 当系统创建完成后Nib后
    /// 因为我们在可视化中关联他
    override func awakeFromNib() {
        super.awakeFromNib()

        initBannerView()
    }
}

extension DiscoveryHeaderView {

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
        
        //设置轮播图内部显示图片的时候调用什么方法
        bannerView.bannerViewSelectorString = "sd_setImageWithURL:placeholderImage:"
        
        // 指示器 默认颜色
        bannerView.pageControlNormalColor = UIColor(hex: COLOR_LIGHT_GREY)
        // 指示器 选中的颜色
        bannerView.pageControlHighlightColor = UIColor(hex: COLOR_PRIMARY)
        
        bannerView.reloadData()
    }
}

extension DiscoveryHeaderView: YJBannerViewDataSource, YJBannerViewDelegate {
    
    /// 返回BannerView要显示的数据
    ///
    func bannerViewImages(_ bannerView: YJBannerView!) -> [Any]! {
        return ["Guide1","Guide2"]
    }
    
    /// 自定义Cell
    /// 复写该方法的目的是
    /// 设置图片的缩放模式
    ///
    func bannerView(_ bannerView: YJBannerView!, customCell: UICollectionViewCell!, index: Int) -> UICollectionViewCell! {
        //将cell类型转为YJBannerViewCell
        let cell = customCell as! YJBannerViewCell
        
        //设置图片的缩放模式为
        //从中心填充
        //多余的裁剪掉
        cell.showImageViewContentMode = .scaleAspectFill
        
        return cell
    }
}
