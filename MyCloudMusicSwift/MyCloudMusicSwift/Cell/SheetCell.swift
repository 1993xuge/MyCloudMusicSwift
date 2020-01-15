//
//  SheetCell.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/14.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SheetCell: UICollectionViewCell {

    static let NAME = "SheetCell"

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivBanner: UIImageView!
    @IBOutlet weak var lbCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //设置封面圆角
        ViewUtil.showSmallRadius(ivBanner)
    }

    /// 绑定数据
    ///
    /// - Parameter data: <#data description#>
    func bindData(_ data: Sheet) {
        //显示标题
        lbTitle.text = data.title

        //设置点击量
        lbCount.text = "\(data.clicks_count)"

        if let imageUri = data.banner {
            // 有图片
            ImageUtil.show(ivBanner, imageUri)
        } else {
            // 没图片
            //设置默认图片
            ivBanner.image = UIImage(named: "PlaceHolder")
        }
    }
}
