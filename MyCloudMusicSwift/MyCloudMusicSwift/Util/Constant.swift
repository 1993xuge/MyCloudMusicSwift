//
//  Constant.swift
//  MyCloudMusicSwift
//
//  常量类 文件
//  主要用来保存项目中用到的字符串，颜色，尺寸，网络请求地址
//
//  Created by wangyixu on 2020/1/8.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

/// 是否是调试模式
let DEBUG = true

// MARK: - 开发环境
/// 网络接口的地址
let ENDPOINT = "http://dev-my-cloud-music-api-rails.ixuea.com"

/// 资源接口地址
let RESOURCE_ENDPOINT = "http://dev-courses-misuc.ixuea.com"

// MARK: - 正式环境
///// 网络接口的地址
//let ENDPOINT="http://my-cloud-music-api-rails.ixuea.com"

/// 资源接口地址
//let RESOURCE_ENDPOINT="http://courses-misuc.ixuea.com"

// MARK: - 尺寸
///立即体验按钮宽度
let SIZE_BUTTON_ENTER_WIDTH = 130.0

///立即体验按钮高度
let SIZE_BUTTON_ENTER_HEIGHT = 44.0

/// 大圆角
let SIZE_LARGE_RADIUS = 22

//小圆角
let SIZE_SMALL_RADIUS = 5

/// 边框宽度
let SIZE_BORDER = 1.0

/// 发现界面；Cell标题高度
let SIZE_TITLE_HEIGHT: CGFloat = 40

/// 大分割线
let SIZE_LARGE_DIVIDER: CGFloat = 10

/// 发现界面头部高度
let SIZE_DISCOVERY_HEADER_HEIGHT: CGFloat = 270

// MARK: - 颜色
/// 全局主色调
/// PRIMARY后缀其实是参考了Android中颜色的命名
let COLOR_PRIMARY = 0xdd0000

/// 亮灰色
let COLOR_LIGHT_GREY = 0xaaaaaa

/// 占位图
let IMAGE_PLACE_HOLDER = "PlaceHolder"

/// 手机号
/// 移动：134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188 198
/// 联通：130 131 132 145 155 156 166 171 175 176 185 186
/// 电信：133 149 153 173 177 180 181 189 199
/// 虚拟运营商: 170
let REGX_PHONE = "^(0|86|17951)?(13[0-9]|15[012356789]|16[6]|19[89]]|17[01345678]|18[0-9]|14[579])[0-9]{8}$"

//邮箱正则表达式
let REGX_EMAIL = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"

// MARK: - 提示字符串

/// 密码格式不正确
let ERROR_PASSWORD_FORMAT = "密码格式不正确！"

// MARK: - QQ第三方登录，分享
let QQ_APP_ID = "101481482"
let QQ_APP_SECRET = "b4304961e7299dde6b7b6964bfbb4a7f"

// MARK: - 新浪微博登录，分享
let WEIBO_APP_KEY = "2844920388"
let WEIBO_APP_SECRET = "6cc6caafbf20dcbb9c46c0e2c52bfdf5"
let WEIBO_REDIRECT_URI = "https://github.com/"

// MARK: - 常量字符串

/// 广告点击了发送的事件
let AD_CLICK = "AD_CLICK"
