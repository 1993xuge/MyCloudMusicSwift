//
//  SongCell.swift
//  歌单Cell
//
//  Created by wangyixu on 2020/1/15.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SongCell: BaseCollectionViewCell {
    static let NAME = "SongCell"

    /// 封面
    @IBOutlet weak var ivBanner: UIImageView!
    
    /// 标题
    @IBOutlet weak var lbTitle: UILabel!
    
    /// 点击量
    @IBOutlet weak var ivAvatar: UIImageView!
    
    /// 歌手头像
    @IBOutlet weak var lbCount: UILabel!
    
    /// 歌手昵称
    @IBOutlet weak var lbNickname: UILabel!
    
    override func initViews() {
        super.initViews()
        
        //设置封面圆角
        ViewUtil.showSmallRadius(ivBanner)
        
        //歌手头像圆角
        ViewUtil.showRadius(ivAvatar, 12)
    }

    /// 绑定数据
    ///
    /// - Parameter data: <#data description#>
    func bindData(_ data: Song) {
        super.awakeFromNib()
        
        //显示图片
        ImageUtil.show(ivBanner, data.banner)
        
        //标题
        lbTitle.text=data.title
        
        //点击量
        lbCount.text="\(data.clicks_count)"
        
        //歌手头像
        ImageUtil.showAvatar(ivAvatar,data.singer.avatar)
        
        //歌手昵称
        lbNickname.text=data.singer.nickname
    }
}
