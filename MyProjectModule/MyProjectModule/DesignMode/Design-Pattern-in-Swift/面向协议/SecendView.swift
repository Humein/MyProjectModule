//
//  SecendView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/22.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class SecendView: UIView, AbstractView {
    
    //MARK: - AbstractView Protocol
    func drink() {
        
    }
    var name: String = ""
    
    //MARK: - AbstractView extension Protocol  可以添加 添加协议的默认实现
    func eat() {
        print("Secend Eat")
    }

}
