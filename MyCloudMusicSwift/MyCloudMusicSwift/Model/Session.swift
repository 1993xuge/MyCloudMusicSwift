//
//  Session.swift
//  MyCloudMusicSwift
//
//  Created by wangyixu on 2020/1/11.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import Foundation

//{
//    "user": 1,
//    "session": "lt1KaAf7tx0IesWBylBn4FFXsjSn_COFvuou_KhemuI",
//    "im_token": "A5uX/U/elKC6w34rAEJOpr/9g/Qr+macnzRSjm0SBueczXTPLmsKBa9cPptdfoFPMioIBCPu2n0Huo5JNVD9iA=="
//}
class Session: BaseModel {
    
    /// 用户Id
    var user:String!
    
    /// 登录标识
    var session:String!
    
    /// 第三方聊天用的标识
    /// 这里没有用到他
    /// 可以不解析
    var im_token:String?
}
