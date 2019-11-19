//
//  BlockModel.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/15.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class BlockModel: NSObject {
    typealias StateCallBack = () -> ()
    var stateBlock :StateCallBack?
    
}
