//
//  FirstView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/22.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class FirstView: UIView, AbstractViewProtocol//, SDTouchAddressBookManagerProtocol{
{
    let secondView = SecondView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //遵循代理
        secondView.delegates = self
    }
    
    deinit {
        print("-------------FirstView")
    }
    
    //MARK: - SDTouchAddressBookManagerProtocol  传值 代理模式 extension FirstView:
//    func readContacts(addressBookArray: Array<[String : Any]>) {
//        print("SDTouchAddressBookManagerProtocol")
//    }

    //MARK: - AbstractView Protocol  抽象组合

    var name: String = ""
    
    
    //MARK: - AbstractView extension Protocol   添加协议的默认实现 能实现面向协议编程
    func eat() {
        print("eat......overwirte")
    }
    
    func eat(_ param: String) {
        print("eat......\(param)")
    }
}



//值得一提的是Swift 的扩展 extension可以用来继承协议,实现代码隔离，便于维护。
extension FirstView: SDTouchAddressBookManagerProtocol{
    /// 实现代理方法
    func readContacts(addressBookArray: Array<[String : Any]>) {
        print("SDTouchAddressBookManagerProtocol")
    }
}
