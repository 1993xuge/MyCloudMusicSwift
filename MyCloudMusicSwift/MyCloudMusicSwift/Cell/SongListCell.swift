//
//  SongListCell.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/16.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SongListCell: BaseTableViewCell {

    static let NAME = "SongListCell"

    /// 第几首音乐
    @IBOutlet weak var lbPosition: UILabel!

    /// 正在播放提示
    @IBOutlet weak var ivPlay: UIImageView!

    /// 音乐标题
    @IBOutlet weak var lbInfo: UILabel!

    /// 音乐信息
    @IBOutlet weak var lbTitle: UILabel!

    /// 更多按钮
    @IBOutlet weak var btMore: UIButton!
    
    override func initViews() {
        super.initViews()
        //去掉默认的选中颜色
        selectionStyle = .none
    }

    /// 绑定数据
    ///
    func bindData(_ data: Song) {
        //设置位置
        lbPosition.text = "\(tag + 1)"

        //设置标题
        lbTitle.text = data.title

        //设置歌手名称
        lbInfo.text = data.singer.nickname
    }

    /// 更多按钮点击事件
    ///
    @IBAction func onMoreClick(_ sender: UIButton) {
        print("SongListCell onMoreClick:\(tag)")
    }

    /// 选中和取消选中调用
    ///
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            //选中

            //隐藏歌曲位置
            lbPosition.isHidden = true

            //显示正在播放的图标
            ivPlay.isHidden = false

            //歌曲标题颜色变为主色调
            lbTitle.textColor = UIColor(hex: COLOR_PRIMARY)
        } else {
            //未选中

            //显示歌曲位置
            lbPosition.isHidden = false

            //隐藏播放按钮
            ivPlay.isHidden = true

            //更改歌曲标题颜色为黑色
            lbTitle.textColor = UIColor.darkText
        }
    }
}
