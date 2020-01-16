//
//  BaseTableViewCell.swift
//  MyCloudMusicSwift
//  通用TableViewCell
//
//  Created by wangyixu on 2020/1/16.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
