//
//  AbstractView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/22.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit
/// AbstractView Protocol
protocol AbstractView {
    func drink()
    var name: String { get }
}

//  添加协议实现
extension AbstractView {
    
    func eat() {
        print("eat......")
    }
}

