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

    /// 当前界面列表数据
    var dataArray: [Any] = []

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

    override func initDatas() {
        super.initDatas()

        fetchBanner()
        
        fetchData()
        
    }

    func fetchBanner() {
        Api.shared.ads().subscribeOnSuccess { data in
            // ListResponse<Ad>?
            if let data = data?.data {
                self.showBannerData(data)
            }
        }.disposed(by: disposeBag)
    }
    
    /// 加载首页数据
    func fetchData() {
        //添加一些测试数据
        dataArray.append("这是标题1")
        dataArray.append("这是标题2")
        dataArray.append("这是标题3")
        dataArray.append("这是标题4")
        dataArray.append("这是标题5")
        dataArray.append("这是标题6")
        dataArray.append("这是标题7")
        dataArray.append("这是标题8")
        dataArray.append("这是标题9")
        dataArray.append("这是标题10")
        dataArray.append("这是标题11")
        dataArray.append("这是标题12")
        dataArray.append("这是标题13")
        
        //重新加载数据
        collectionView.reloadData()
    }

    /// 显示轮播图数据
    ///
    /// - Parameter data: <#data description#>
    func showBannerData(_ data: [Ad]) {
        //将数据设置到头部控件中
        header.bindData(data)
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
        return dataArray.count
    }

    /// 返回当前位置的Cell
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.NAME, for: indexPath) as! TitleCell

        //取出当前位置对应的数据
        let data = dataArray[indexPath.row]

        //绑定数据
        cell.bindData(data as! String)

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

        //设置轮播图点击的回调方法
        //类似于OC中的block
        header.onBannerClick = { data in
            print("DiscoveryController onBannerClick:\(data.title)")

            //使用Web控制器显示广告界面
            WebController.start(self.navigationController!, data.title, data.uri)
        }

        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //获取到当前CollectionView的宽度
        let collectionViewWidth = collectionView.frame.width

        return CGSize(width: collectionViewWidth, height: 270)
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

        return CGSize(width: collectionViewWidth, height: 40)
    }
}
