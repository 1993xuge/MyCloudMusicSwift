//
//  BaseCollectionReusableView.swift
//  MyCloudMusicSwift

//  通用的CollectionReusableView
//  作用是将类中的方法在逻辑层面层面上拆分为三个方法
//  这个思路和前面拆分Controller是一样

//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    
    /// 当系统创建这个Nib的时候
    /// 就会调用这个方法
    /// 因为Nib关联了这个类
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
    
    /// 初始化监听器
    func initListeners() {
        
    }
}
