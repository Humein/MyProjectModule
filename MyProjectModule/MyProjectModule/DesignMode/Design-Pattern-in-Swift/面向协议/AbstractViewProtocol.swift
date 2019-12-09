//
//  AbstractView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/22.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit
/// AbstractView Protocol
protocol AbstractViewProtocol {
    func drink()
    var name: String { get }
}

protocol SDTouchAddressBookManagerProtocol {
    /// 注意异步回调
    /// - Parameter addressBookArray: Array<[String : Any]>
    func readContacts(addressBookArray :Array<[String : Any]>)
}


// 使用扩展为协议提供默认的实现
extension AbstractViewProtocol {
    func drink(){
        print("drink......default")
    }
    // 正向传值
    func eat(_ param: String) {
        print("eat......\(param)")
    }
}

