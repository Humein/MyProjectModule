//
//  SecondView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/9.
//  Copyright © 2019 xinxin. All rights reserved.


import UIKit

class SecondView: UIView {

    deinit {
        print("-------------SecondView")
    }
    
    /// 代理
    var delegates: SDTouchAddressBookManagerProtocol? = nil

    override func willRemoveSubview(_ subview: UIView) {
        /// 如果某些情况, 代理不能销毁可以手动将delegates 置nil<SDTouchAddressBookManager>
        delegates = nil
    }
    
    //执行协议方法
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegates?.readContacts(addressBookArray: [])
    }

}
