//
//  SheetDetailHeaderView.swift
//  MyCloudMusicSwift
//  歌单详情头部
//
//  Created by wangyixu on 2020/1/16.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SheetDetailHeaderView: UITableViewHeaderFooterView {

    static let NAME = "SheetDetailHeaderView"

    /// 歌单封面
    @IBOutlet weak var ivBannerView: UIImageView!

    /// 歌单标题
    @IBOutlet weak var lbTitle: UILabel!

    /// 用户信息容器
    @IBOutlet weak var svUserInfo: UIStackView!

    /// 歌单创建人的头像
    @IBOutlet weak var ivAvatar: UIImageView!

    /// 歌单创建人的昵称
    @IBOutlet weak var lbNickname: UILabel!

    /// 歌单评论数
    @IBOutlet weak var lbCommentCount: UILabel!

    /// 歌单分享数
    @IBOutlet weak var lbShareCount: UILabel!

    /// 歌单下面的快捷按钮容器
    @IBOutlet weak var vwControl: UIView!

    /// 歌单音乐数
    @IBOutlet weak var lbSongCount: UILabel!

    /// 收藏歌单的按钮
    @IBOutlet weak var btCollection: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置封面圆角
        ViewUtil.showSmallRadius(ivBannerView)

        //设置用户头像圆角
        ViewUtil.showRadius(ivAvatar, 15)
        
        //用户信息点击事件
        svUserInfo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onUserInfoClick)))
        
        //播放全部
        vwControl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPlayAllClick)))
    }
    
    /// 用户信息点击
    @objc func onUserInfoClick() {
        print("SheetDetailHeaderView onUserInfoClick")
    }
    
    /// 播放所有音乐
    @objc func onPlayAllClick() {
        print("SheetDetailHeaderView onPlayAllClick")
    }

    /// 歌单评论点击
    @IBAction func onCommentClick(_ sender: UIButton) {
        print("SheetDetailHeaderView onCommentClick")
    }

    /// 收藏歌单点击
    @IBAction func onCollectionClick(_ sender: UIButton) {
        print("SheetDetailHeaderView onCollectionClick")
    }
}
