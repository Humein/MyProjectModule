//
//  FacadePattern.swift
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/3/1.
//  Copyright © 2021 xinxin. All rights reserved.
//

import Foundation
// 外观模式为子系统中的一组接口提供一个统一的高层接口，使得子系统更容易使用。
// 就是对三方SDK的封装。。。
// 外观模式为现有对象定义了一个新接口， 适配器则会试图运用已有的接口。 适配器通常只封装一个对象， 外观通常会作用于整个对象子系统上。
final class Defaults {

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    subscript(key: String) -> String? {
        get {
            return defaults.string(forKey: key)
        }

        set {
            defaults.set(newValue, forKey: key)
        }
    }
}
/*:
### 用法
*/
let storage = Defaults()
//
//// Store
//storage["Bishop"] = "Disconnect me. I’d rather be nothing"
//
//// Read
//storage["Bishop"]

