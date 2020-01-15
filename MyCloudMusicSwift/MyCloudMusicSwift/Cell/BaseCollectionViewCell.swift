//
//  BaseCollectionViewCell.swift
//  MyCloudMusicSwift
//  通用CollectionViewCell
//
//  Created by wangyixu on 2020/1/15.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViews()
        initDatas()
        initListeners()
    }
    
    /// 初始化控件
    func initViews() {
        
    }
    
    /// 初始化数据
    func initDatas() {
        
    }
    
    /// 初始监听器
    func initListeners() {
        
    }
}
