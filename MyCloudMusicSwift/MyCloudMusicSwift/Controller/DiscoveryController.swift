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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        navigationItem.title = "发现"
        
        //
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
}
