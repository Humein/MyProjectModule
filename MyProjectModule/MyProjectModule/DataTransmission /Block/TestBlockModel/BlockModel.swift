//
//  BlockModel.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/15.
//  Copyright © 2019 xinxin. All rights reserved.
// https://zhuanlan.zhihu.com/p/92464947

import UIKit

class BlockModel: NSObject {
    typealias StateCallBack = (Any) -> ()
    var stateBlock :StateCallBack?
    var title: String?
    
}
