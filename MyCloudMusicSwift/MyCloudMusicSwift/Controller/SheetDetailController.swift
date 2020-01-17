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

    @IBOutlet weak var ivBackground: UIImageView!

    /// 背景容器的高度约束
    @IBOutlet weak var backgroundContainerHeight: NSLayoutConstraint!

    /// 歌单Id
    var id: String!

    /// 歌单
    var data: Sheet!

    /// 列表数据
    var dataArray: [Song] = []

    /// 头部
    var header: SheetDetailHeaderView!

    /// 视图即将可见
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //设置导航栏透明
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)

        //去除导航栏下面的阴影
        navigationController?.navigationBar.shadowImage = UIImage()

        //设置导航栏样式
        //这里将导航栏的背景设置为黑色
        //这样的话状态栏文字颜色就会自动变为白色
        //如果界面有了导航栏只能通过这种方式修改
        navigationController!.navigationBar.barStyle = .black

        //设置返回按钮为白色
        setNavigationBarTintColor(.white)
    }

    /// 视图即将消失
    ///
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //还原导航栏透明
        navigationController!.navigationBar.setBackgroundImage(nil, for: .default)

        //还原导航栏下面的阴影
        navigationController!.navigationBar.shadowImage = nil

        //还原导航栏样式
        navigationController!.navigationBar.barStyle = .default

        //设置返回按钮为黑色
        setNavigationBarTintColor(.black)
    }


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

        //添加右侧按钮
        //分享
        let shareBarItem = UIBarButtonItem(image: UIImage(named: "Share"), style: .plain, target: self, action: #selector(onShareClick(sender:)))

        // 更多
        let moreBarItem = UIBarButtonItem(image: UIImage(named: "MoreWhite"), style: .plain, target: self, action: #selector(onMoreClick(sender:)))

        //将button添加到导航栏右侧
        //从右到左
        navigationItem.rightBarButtonItems = [moreBarItem, shareBarItem]
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

        // 显示 背景
        ImageUtil.show(ivBackground, data.banner)

        //显示头部数据
        header.bindData(data)

        //添加歌曲数据
        if let songs = data.songs {
            dataArray = dataArray + songs
        }

        //重新加载数据
        tableView.reloadData()
    }

    /// 处理收藏和取消收藏逻辑
    func processCollectionClick() {
        if data.isCollection() {
            //已经收藏了

            //取消收藏

            Api.shared.deleteCollect(data.id).subscribeOnSuccess { response in
                // DetailResponse<BaseModel>?
                //取消收藏成功
                self.data.collection_id = nil

                //收藏数-1
                self.data.collections_count -= 1

                //刷新收藏状态
                self.header.showCollectionStatus()
            }.disposed(by: disposeBag)
        } else {
            //没有收藏

            //收藏
            Api.shared.collect(data.id).subscribeOnSuccess { response in
                // DetailResponse<BaseModel>?
                //收藏成功

                //收藏状态变更后
                //可以重新点击歌单详情界面
                //获取收藏状态
                //但对于收藏来说
                //收藏数可能没那么重要
                //所以不用及时刷新

                self.data.collection_id = 1

                //收藏数量+1
                self.data.collections_count += 1

                //刷新收藏状态
                self.header.showCollectionStatus()
            }.disposed(by: disposeBag)
        }
    }

    /// 分享按钮点击了
    ///
    @objc func onShareClick(sender: UIButton) {
        print("SheetDetailController onShareClick")
    }

    /// 更多按钮点击了
    ///
    @objc func onMoreClick(sender: UIButton) {
        print("SheetDetailController onMoreClick")
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

        //设置评论列表点击回调方法
        header.onCommentClick = {
            print("SheetDetailController onCommentClick:\(self.data.title)")

            CommentController.start(self.navigationController!, sheet: self.data.id)
        }

        //设置收藏点击回调方法
        header.onCollectionClick = {
            print("SheetDetailController onCollectionClick")
            self.processCollectionClick()
        }

        //设置用户点击回调方法
        header.onUserClick = {
            print("SheetDetailController onUserClick")

            UserDetailController.start(self.navigationController!, userId: self.data.user.id)
        }

        //播放全部点击回调方法
        header.onPlayClick = {
            print("SheetDetailController onPlayClick")
        }

        //返回Header
        return header
    }

    /// 返回Header高度
    ///
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //20(分割线)+140+20(分割线)+52+20(分割线)+55.5
        return 307.5
    }

    /// TableView滚动的时候就会调用
    ///
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //垂直方向上滚动的距离
        //不滚动的时候为0
        //在0的位置向上滚动为正
        //在0的位置向下滚动为负
        let offsetY = scrollView.contentOffset.y

        print("SheetDetailController scrollViewDidScroll:\(offsetY)")

        //动态更改背景高度约束的值
        //导航栏+Heade高度=350（大概计算）
        backgroundContainerHeight.constant = 350 - offsetY
    }

    /// 点击Cell回调方法
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         //跳转到简单播放界面
        SimpletPlayerController.start(navigationController!)
    }
}
