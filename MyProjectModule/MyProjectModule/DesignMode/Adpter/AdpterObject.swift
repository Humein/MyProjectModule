//
//  AdpterObject.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/11.
//  Copyright © 2019 xinxin. All rights reserved.
//
/*
 适配器模式是用来提供另两个不兼容的类型之间的联系,通过包装“adaptee”类,支持客户端所需的接口。
 */

import UIKit

protocol NewDeathStarSuperLaserAiming {
    var angleV: Double { get }
    var angleH: Double { get }
    func newMethod()
}

/*:
**Adaptee**
*/
struct OldDeathStarSuperlaserTarget {
    let angleHorizontal: Float
    let angleVertical: Float

    init(angleHorizontal: Float, angleVertical: Float) {
        self.angleHorizontal = angleHorizontal
        self.angleVertical = angleVertical
    }
    
    func oldMethod() -> String{
        return "OldDeathStarSuperlaserTarget"
    }
}

/*:
**Adapter**
*/
// 方式 1
class NewDeathStarSuperlaserClass: NSObject {

    // 对象适配器
    private let target: OldDeathStarSuperlaserTarget

    init(_ target: OldDeathStarSuperlaserTarget) {
        self.target = target
    }
    
    var angleH: Double {
        // 适配   Float -> Double
        return Double(target.angleHorizontal)
    }

    func newMethod() {
        print("NewDeathStarSuperlaserClass" + target.oldMethod())
    }
}

// 协议好处是 可以统一接口，同时方便创建多个适配器
// 方式 2
struct NewDeathStarSuperlaserTarget: NewDeathStarSuperLaserAiming {

    // 对象适配器
    private let target: OldDeathStarSuperlaserTarget

    var angleV: Double {
        // 适配   Float -> Double
        return Double(target.angleVertical)
    }

    var angleH: Double {
        // 适配   Float -> Double
        return Double(target.angleHorizontal)
    }

    func newMethod() {
        print("NewDeathStarSuperlaserTarget" + target.oldMethod())
    }
    init(_ target: OldDeathStarSuperlaserTarget) {
        self.target = target
    }
}


//MARK:- Usage
class AdpterObject: NSObject {
    override init() {
        let target = OldDeathStarSuperlaserTarget(angleHorizontal: 14.0, angleVertical: 12.0)
        let newFormat = NewDeathStarSuperlaserTarget(target)

        newFormat.angleH
        newFormat.angleV

    }
}

