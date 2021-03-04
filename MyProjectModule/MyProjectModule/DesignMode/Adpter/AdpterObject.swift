//
//  AdpterObject.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/11.
//  Copyright © 2019 xinxin. All rights reserved.
//
/*
 适配器模式是用来提供另两个不兼容的类型之间的联系,通过包装“adaptee”类,支持客户端所需的接口。
 适配器模式:  对已有对象的接口进行修改。
 
 外观模式为现有对象定义了一个新接口(侧重于对程序接口提前设计)， 适配器则会试图运用已有的接口(侧重于对当前程序接口修补)。
 适配器通常只封装一个对象， 外观通常会作用于整个对象子系统上。
 
 适配器模式中可以定义一个包装类，包装不兼容接口的对象，这个包装类指的就是适配器(Adapter)，它所包装的对象就是适配者(Adaptee)，即被适配的类

 */

import UIKit

//MARK: - 实现一

/*
 Adaptee
*/
struct OldTarget {
    let width: Float
    let height: Float

    init(_ width: Float,_ height: Float) {
        self.width = width
        self.height = height
    }
    
    func oldMethod() -> String{
        return "OldTarget"
    }
}

/*
 Adapter 1
*/
// 方式 1
class NewDeathStarSuperlaserClass: NSObject {

    // 对象适配器
    private let target: OldTarget

    init(_ target: OldTarget) {
        self.target = target
    }
    
    var angleWidth: Double {
        // 适配   Float -> Double
        return Double(target.width)
    }

    func oldMethod() {
        print("NewDeathStarSuperlaserClass" + target.oldMethod())
    }
}

// 协议好处是 可以统一接口，同时方便创建多个适配器
// 方式 2

protocol NewTargetProtocol {
    var width: Double { get }
    var height: Double { get }
    func oldMethod()
}

/*
Adapter 2
*/
struct NewTarget: NewTargetProtocol {

    // 对象适配器
    private let target: OldTarget

    var width: Double {
        // 适配   Float -> Double
        return Double(target.width)
    }

    var height: Double {
        // 适配   Float -> Double
        return Double(target.height)
    }

    func oldMethod() {
        print("NewTarget" + target.oldMethod())
    }
    
    init(_ target: OldTarget) {
        self.target = target
    }
}


func Usage() {
    let target = OldTarget(14.0,12.0)
    let newFormat = NewTarget(target)
    newFormat.oldMethod()
    _ = newFormat.width
    _ = newFormat.height
}


//MARK: - 实现二

/// The Target defines the domain-specific interface used by the client code.
class Targets {

    func request() -> String {
        return "Target: The default target's behavior."
    }
}

/// The Adaptee contains some useful behavior, but its interface is incompatible
/// with the existing client code. The Adaptee needs some adaptation before the
/// client code can use it.
class Adaptee {

    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }
}

/// The Adapter makes the Adaptee's interface compatible with the Target's
/// interface.
class Adapter: Targets {

    private var adaptee: Adaptee

    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    override func request() -> String {
        return "Adapter: (TRANSLATED) " + adaptee.specificRequest().reversed()
    }
}

/// The client code supports all classes that follow the Target interface.
class Clients {
    // ...
    static func someClientCode(target: Targets) {
        print(target.request())
    }
    // ...
}

/// Let's see how it all works together.
class AdapterConceptual: NSObject {

    func testAdapterConceptual() {
        print("Client: I can work just fine with the Target objects:")
        Clients.someClientCode(target: Targets())

        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print("Adaptee: " + adaptee.specificRequest())

        print("Client: But I can work with it via the Adapter:")
        Client.someClientCode(component: Adapter(adaptee) as! Component)
    }
}
