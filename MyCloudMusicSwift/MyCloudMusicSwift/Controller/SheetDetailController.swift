//
//  SheetDetailController.swift
//  MyCloudMusicSwift
//  歌单详情
//
//  Created by wangyixu on 2020/1/16.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import UIKit

class SheetDetailController: BaseTitleController {

    /// 列表控件
    @IBOutlet weak var tableView: UITableView!

    /// 歌单Id
    var id: String!

    override func initViews() {
        super.initViews()

        setTitle("标题")

        //设置数据源和代理
        //这里使用的代码设置
        //在发现页面使用的是可视化
        //两者功能上没什么区别
        //大家可以看情况选择
        tableView.delegate = self
        tableView.dataSource = self

        // 注册 Cell
        tableView.register(UINib(nibName: SongListCell.NAME, bundle: nil), forCellReuseIdentifier: SongListCell.NAME)
    }
}

extension SheetDetailController {
    /// 启动方法
    ///
    /// - Parameters:
    ///   - navigationController: navigationController description
    ///   - id: 歌单 id
    static func start(_ navigationController: UINavigationController, _ id: String) {

        //获取到Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        //创建控制器
        let controller = storyboard.instantiateViewController(withIdentifier: "SheetDetail") as! SheetDetailController

        //传递参数
        controller.id = id

        //将控制器压入导航控制器
        navigationController.pushViewController(controller, animated: true)
    }
}

extension SheetDetailController: UITableViewDelegate, UITableViewDataSource {

    /// 有多少行
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    /// 返回Cell
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //获取Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: SongListCell.NAME) as! SongListCell

        //绑定数据

        //返回Cell
        return cell
    }


}
