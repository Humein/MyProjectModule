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
//  外观模式为现有对象定义了一个新接口， 适配器则会试图运用已有的接口。 适配器通常只封装一个对象， 外观通常会作用于整个对象子系统上。

// MARK: 封装单个SDK
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

func usages() {
    // Store
    UserDefaults.standard.set("call me", forKey: "Bob")
    Defaults()["Bob"] = "call me"
    // Read
    UserDefaults.standard.string(forKey: "Bob")
    _ = Defaults()["Bob"]
}


//MARK: 封装多个组合SDK

// 为了将框架的复杂性隐藏在一个简单接口背后，我们创建了一个外观类。它是在功能性和简洁性之间做出的权衡。
class Facade {

    private var sdk1: NSString
    private var sdk2: NSNumber

    init(subsystem1: NSString = NSString(),
         subsystem2: NSNumber = NSNumber()) {
        self.sdk1 = subsystem1
        self.sdk2 = subsystem2
    }

    // 对外暴露API
    func operation() -> String {
        let result = ""
        // 做 sdk1 与 sdk2 混合处理数据
        return result
    }
}

// 应用程序的类并不依赖于复杂框架中成千上万的类。同样，如果你决定更换框架，那只需重写外观类即可。
class FPClient {
    // ...
    static func clientCode(facade: Facade) {
        print(facade.operation())
    }
    // ...
}
func testFacadeConceptual() {
    let subsystem1 = NSString()
    let subsystem2 = NSNumber()
    let facade = Facade(subsystem1: subsystem1, subsystem2: subsystem2)
    FPClient.clientCode(facade: facade)
}

