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

        collectionView.register(UINib(nibName: SheetCell.NAME, bundle: nil), forCellWithReuseIdentifier: SheetCell.NAME)
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

        //清除原来的数据
        dataArray.removeAll()

        Api.shared.sheets().subscribeOnSuccess { data in
            // ListResponse<Sheet>?
            if let data = data?.data {
                //添加标题
                self.dataArray.append("推荐歌单")

                //添加到歌单数据
                self.dataArray = self.dataArray + data

                //重新加载数据
                self.collectionView.reloadData()
            }
        }.disposed(by: disposeBag)
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

    /// 获取列表类型
    ///
    func typeForItemAtData(_ data: Any) -> CellType {
        if data is Sheet {
            //歌单
            return .sheet
        }
        //        else if  data is Song {
        //
        //        }

        //标题
        return .title
    }

    /// Cell类型
    /// 他是一个枚举
    /// 以后也可以重构
    /// 就是项目中所有的类型都用他
    ///
    /// - title: 标题
    /// - sheet: 歌单
    /// - song: 单曲
    enum CellType {
        case title
        case sheet
        case song
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

        //取出当前位置对应的数据
        let data = dataArray[indexPath.row]

        let type = typeForItemAtData(data)

        switch type {
        case .sheet:

            //歌单
            //从CollectionView中取出一个Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SheetCell.NAME, for: indexPath) as! SheetCell

            //绑定数据
            cell.bindData(data as! Sheet)

            //返回Cell
            return cell

        default:
            //标题
            //从CollectionView中取出一个Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.NAME, for: indexPath) as! TitleCell

            //绑定数据
            cell.bindData(data as! String)

            //返回Cell
            return cell
        }
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

        return CGSize(width: collectionViewWidth, height: SIZE_DISCOVERY_HEADER_HEIGHT)
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

        return SIZE_LARGE_DIVIDER
    }

    /// 返回每个Cell的列间距
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SIZE_LARGE_DIVIDER
    }

    /// 返回当前Cell的大小
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //获取CollectionView的宽
        let collectionViewWidth = collectionView.frame.width

        //获取当前位置对应的数据
        let data = dataArray[indexPath.row]

        //最终的宽高
        var width: CGFloat!
        var height: CGFloat!

        //获取当前对象的类型
        let type = typeForItemAtData(data)

        switch type {
        case .sheet:
            //歌单
            //3列
            width = (collectionViewWidth - SIZE_LARGE_DIVIDER * 2) / 3

            //计算高度
            height = width + SIZE_LARGE_DIVIDER*2 + SIZE_TITLE_HEIGHT
        default:
            //标题
            width = collectionViewWidth
            height = SIZE_TITLE_HEIGHT
        }
        return CGSize(width: width, height: height)
    }
}
