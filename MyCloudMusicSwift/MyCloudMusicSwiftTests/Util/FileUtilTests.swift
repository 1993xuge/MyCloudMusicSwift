//
//  FileUtilTests.swift
//  MyCloudMusicSwiftTests
//
//  Created by wangyixu on 2020/1/10.
//  Copyright © 2020 wangyixu. All rights reserved.
//

import XCTest

class FileUtilTests: XCTestCase {

    /// 测试文件大小格式化
    func testFormatFileSize() {
        
        //第一个参数等于第二个参数
        XCTAssertEqual(FileUtil.formatFileSize(1), "1.00Byte")
        
        //第一个参数等于第二个参数
        //1234/1024=1.205078125
        XCTAssertEqual(FileUtil.formatFileSize(1234), "1.21K")
        
        //第一个参数不等于第二个参数
        XCTAssertNotEqual(FileUtil.formatFileSize(1234), "1.23K")
    }

}
