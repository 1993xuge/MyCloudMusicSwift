//
//  DiscoveryController.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/13.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class DiscoveryController: BaseCommonController {

    @IBOutlet weak var collectionView: UICollectionView!

    /// 当前界面头部布局
    var header: DiscoveryHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        navigationItem.title = "发现"


        // 注册 头部
        collectionView.register(UINib(nibName: DiscoveryHeaderView.NAME, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoveryHeaderView.NAME)

        // 创建 有个 标题 NIB
        let titleNib = UINib(nibName: TitleCell.NAME, bundle: nil)

        // 注册Cell
        collectionView.register(titleNib, forCellWithReuseIdentifier: TitleCell.NAME)


    }

    override func initListeners() {
        super.initListeners()

        print("initListeners")
        //添加一个通知监听

        //当用户点击了启动界面的广告
        //就会调用当前界面的onAdClick方法
        NotificationCenter.default.addObserver(self, selector: #selector(onAdClick(notification:)), name: NSNotification.Name(rawValue: AD_CLICK), object: nil)
    }

    /// 当用户点击了启动界面的广告后回调
    ///
    /// - Parameter notification: <#notification description#>
    @objc func onAdClick(notification: NSNotification) {
        let adUri = notification.userInfo!["adUri"] as! String
        print("DiscoveryController onAdClick:\(adUri)")

        WebController.start(navigationController!, "活动详情", adUri)
    }
}

extension DiscoveryController: UICollectionViewDataSource, UICollectionViewDelegate {

    /// 返回有多个条目
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    /// 返回当前位置的Cell
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.NAME, for: indexPath)

        return cell
    }

    /// 返回CollectionView的Header
    ///
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        //将header中的内容都封装到单独的View中
        //好处是当前界面简洁一些
        //但坏处是头部的点击事件，需要通过一些方法
        //才能回调到当前界面

        header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoveryHeaderView.NAME, for: indexPath) as! DiscoveryHeaderView

        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //获取到当前CollectionView的宽度
        let collectionViewWidth=collectionView.frame.width
        
        return CGSize(width: collectionViewWidth, height: 100)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout代理相关的方法
// 返回CollectionView相关的间隔
extension DiscoveryController: UICollectionViewDelegateFlowLayout {

    /// 返回CollectionView里面的Cell到CollectionView的间距
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    /// 返回每个Cell的行间距
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    /// 返回每个Cell的列间距
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    /// 返回当前Cell的大小
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //获取CollectionView的宽
        let collectionViewWidth = collectionView.frame.width

        //计算每列的宽度
        let width = (collectionViewWidth - 10 * 2) / 3

        //返回当前Cell宽高
        return CGSize(width: width, height: width)
    }
}
