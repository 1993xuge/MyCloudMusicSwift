//
//  DiscoveryHeaderView.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class DiscoveryHeaderView: BaseCollectionReusableView {

    static let NAME = "DiscoveryHeaderView"

    /// 轮播图
    @IBOutlet weak var bannerView: YJBannerView!
    
    

    /// 轮播图点击回调方法
    var onBannerClick: ((_ data: Ad) -> Void)!

    /// 轮播图的数据
    var dataArray: [String] = []

    /// 用来保存广告数据
    var data: [Ad]!
    
    override func initViews() {
        // 设置 轮播图 圆角
        ViewUtil.showSmallRadius(bannerView)
        
        initBannerView()
    }

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

        //        bannerView.reloadData()
    }

    /// 显示数据
    ///
    func bindData(_ data: [Ad]) {

        self.data = data

        //清除原来的数据
        dataArray.removeAll()

        //循环每一个广告
        //取出广告的地址
        //放到一个数组中
        for ad in data {
            dataArray.append(ResourceUtil.resourceUri(ad.banner!))
        }

        //通知轮播图框架从新加载数据
        bannerView.reloadData()
    }
    
    // MARK: - 快捷按钮点击事件
    
    /// 每日推荐按钮点击
    ///
    @IBAction func onDayClick(_ sender: UIButton) {
        print("DiscoveryHeaderView onDayClick")
    }
    
    /// 歌单按钮点击
    ///
    @IBAction func onSheetClick(_ sender: UIButton) {
        print("DiscoveryHeaderView onSheetClick")
    }
    
    /// 私人FM点击
    ///
    @IBAction func onFMClick(_ sender: UIButton) {
        print("DiscoveryHeaderView onFMClick")
    }
    
    /// 排行榜点击
    ///
    @IBAction func onRankClick(_ sender: UIButton) {
        print("DiscoveryHeaderView onRankClick")
    }
    
}

extension DiscoveryHeaderView: YJBannerViewDataSource, YJBannerViewDelegate {

    /// 返回BannerView要显示的数据
    ///
    func bannerViewImages(_ bannerView: YJBannerView!) -> [Any]! {
        return dataArray
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

    /// banner点击回调方法
    ///
    func bannerView(_ bannerView: YJBannerView!, didSelectItemAt index: Int) {
        print("DiscoveryHeaderView didSelectItemAtIndex:\(index)")

        //获取当前点击的广告对象
        let ad = data[index]

        //调用轮播图回调方法
        onBannerClick(ad)
    }
}
