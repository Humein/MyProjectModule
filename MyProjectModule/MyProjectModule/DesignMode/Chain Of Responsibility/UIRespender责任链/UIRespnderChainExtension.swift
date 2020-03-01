//
//  UIRespnderChainExtension.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/3/1.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

extension UIResponder {
    @objc func responder(eventName: String, userInfo: String) {
        print("Responder的对象: \(type(of: self))")
        self.next?.responder(eventName: eventName, userInfo: userInfo)
    }
}

class ViewA: UIView {
    override func responder(eventName: String, userInfo: String) {
        super.responder(eventName: eventName, userInfo: userInfo)
    }
}

class ViewB: UIView {
    override func responder(eventName: String, userInfo: String) {
        super.responder(eventName: eventName, userInfo: userInfo)
    }
}

class ViewC: UIView {
    override func responder(eventName: String, userInfo: String) {
        super.responder(eventName: eventName, userInfo: userInfo)
    }
}
