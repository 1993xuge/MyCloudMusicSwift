//
//  SheetDetailHeaderView.swift
//  MyCloudMusicSwift
//  歌单详情头部
//
//  Created by wangyixu on 2020/1/16.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SheetDetailHeaderView: BaseTableViewHeaderFooterView {

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

    private var data: Sheet!

    /// 评论点击回调
    var onCommentClick: (() -> Void)!

    /// 收藏回调方法
    var onCollectionClick: (() -> Void)!

    /// 用户点击回调方法
    var onUserClick: (() -> Void)!

    /// 播放全部点击回调方法
    var onPlayClick: (() -> Void)!

    override func initViews() {
        super.initViews()

        //设置封面圆角
        ViewUtil.showSmallRadius(ivBannerView)

        //设置用户头像圆角
        ViewUtil.showRadius(ivAvatar, 15)

        //用户信息点击事件
        svUserInfo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onUserInfoClick)))

        //播放全部
        vwControl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPlayAllClick)))

        DispatchQueue.main.async {
            self.setControlRadius()
        }
    }

    /// 设置按钮组圆角
    func setControlRadius() {
        //设置按钮组圆角
        //这里要设置左上，右上为圆角

        //设置切哪个直角
        //UIRectCornerTopLeft     = 1 << 0,  左上角
        //UIRectCornerTopRight    = 1 << 1,  右上角
        //UIRectCornerBottomLeft  = 1 << 2,  左下角
        //UIRectCornerBottomRight = 1 << 3,  右下角
        //UIRectCornerAllCorners  = ~0UL     全部角

        //创建遮罩
        //类似PS中的蒙版
        let maskPath = UIBezierPath(roundedRect: vwControl.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: SIZE_LARGE_DIVIDER, height: SIZE_LARGE_DIVIDER))

        //创建layer
        let maskLayer = CAShapeLayer()

        //设置frame
        maskLayer.frame = vwControl.bounds

        //设置layer路径
        maskLayer.path = maskPath.cgPath

        //设置控件组layer
        vwControl.layer.mask = maskLayer
    }

    /// 用户信息点击
    @objc func onUserInfoClick() {
        print("SheetDetailHeaderView onUserInfoClick")

        onUserClick()
    }

    /// 播放所有音乐
    @objc func onPlayAllClick() {
        print("SheetDetailHeaderView onPlayAllClick")
        onPlayClick()
    }

    /// 歌单评论点击
    @IBAction func onCommentClick(_ sender: UIButton) {
        print("SheetDetailHeaderView onCommentClick")
        onCommentClick()
    }

    /// 收藏歌单点击
    @IBAction func onCollectionClick(_ sender: UIButton) {
        print("SheetDetailHeaderView onCollectionClick")
        onCollectionClick()
    }

    func bindData(_ data: Sheet) {
        self.data = data

        //显示歌单封面
        ImageUtil.show(ivBannerView, data.banner)

        //歌单标题
        lbTitle.text = data.title

        //歌单创建者的头像
        ImageUtil.showAvatar(ivAvatar, data.user.avatar)

        //歌单创建者的昵称
        lbNickname.text = data.user.nickname

        //歌单评论数
        lbCommentCount.text = "\(data.comments_count)"

        //显示当前歌单音乐数量
        if let songs = data.songs {
            lbSongCount.text = "(共\(songs.count)首)"
        }

        //显示收藏状态
        showCollectionStatus()
    }

    /// 显示收藏状态
    func showCollectionStatus() {

        if data.isCollection() {
            // 收藏了

            //将按钮文字改为取消
            btCollection.setTitle("取消(\(data.collections_count))", for: .normal)

            //弱化取消收藏按钮
            //因为我们的本质是想让用户收藏歌单
            //所以去掉背景
            btCollection.backgroundColor = UIColor.clear

            //设置文字颜色为灰色
            btCollection.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            // 没有 收藏

            //将按钮文字改为收藏
            btCollection.setTitle("收藏(\(data.collections_count))", for: .normal)

            //设置按钮颜色为主色调
            btCollection.backgroundColor = UIColor(hex: COLOR_PRIMARY)

            //将文字颜色设置为白色
            btCollection.setTitleColor(.white, for: .normal)
        }
    }


}
