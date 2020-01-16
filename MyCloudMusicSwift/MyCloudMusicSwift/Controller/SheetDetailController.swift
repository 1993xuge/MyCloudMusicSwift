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

    /// 歌单
    var data: Sheet!

    /// 列表数据
    var dataArray: [Song] = []

    /// 头部
    var header: SheetDetailHeaderView!

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

        // 注册 Header
        tableView.register(UINib(nibName: SheetDetailHeaderView.NAME, bundle: nil), forHeaderFooterViewReuseIdentifier: SheetDetailHeaderView.NAME)

        // 注册 歌单列表Cell
        tableView.register(UINib(nibName: SongListCell.NAME, bundle: nil), forCellReuseIdentifier: SongListCell.NAME)
    }

    override func initDatas() {
        super.initDatas()

        fetchData()
    }

    func fetchData() {
        //获取数据
        Api.shared
            .sheetDetail(id: id)
            .subscribeOnSuccess { data in
                // DetailResponse<Sheet>?

                if let data = data?.data {
                    self.showData(data)
                }
            }.disposed(by: disposeBag)
    }

    /// 显示数据
    ///
    /// - Parameter data: <#data description#>
    func showData(_ data: Sheet) {
        self.data = data

        //添加歌曲数据
        dataArray = dataArray + data.songs

        //重新加载数据
        tableView.reloadData()
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
        return dataArray.count
    }

    /// 返回Cell
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //获取Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: SongListCell.NAME) as! SongListCell

        //设置Tag
        //目的是在Cell中显示当前音乐位置
        cell.tag = indexPath.row

        //绑定数据
        cell.bindData(dataArray[indexPath.row])

        //返回Cell
        return cell
    }

    /// 返回Header
    ///
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SheetDetailHeaderView.NAME) as! SheetDetailHeaderView

        //返回Header
        return header
    }

    /// 返回Header高度
    ///
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //20(分割线)+140+20(分割线)+52+20(分割线)+55.5
        return 307.5
    }

}
