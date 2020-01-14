//
//  TitleCell.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class TitleCell: UICollectionViewCell {

    /// 当前Cell的名称
    static let NAME = "TitleCell"

    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// 显示数据
    ///
    func bindData(_ data:String) {
        lbTitle.text = data
    }

}
