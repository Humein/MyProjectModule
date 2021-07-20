//
//  XXNamespaceProtocol.swift
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/7/2.
//

import UIKit
// MARK: - 方式1
/**
 原理
 原理： 对原类型进行一层封装。然后，对这个封装进行自定义的方法扩展。
 */

/// 定义泛型类
// 首先定义一个泛型类 JTKit，使用泛型 Base
public struct JTKit<Base> {
    private let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// 定义泛型协议
// 定义了一个 JTWrappable 协议，这个协议代表了支持 namespace 形式的扩展。并紧接着给这个协议 extension 了默认实现。这样实现了这个协议的类型就不需要自行实现协议所约定的内容了 ;定义支持泛型的协议 JTWrappable，并通过协议扩展提供协议的默认实现，返回实现泛型类 JTKit 的对象自身
public protocol JTWrappable {
    associatedtype WrappableType
    
    var jt: WrappableType { get }
}

// 协议的扩展
public extension JTWrappable {
    var jt: JTKit<Self> {
        get { return JTKit(self) }
    }
}



// 用法：

/// 实现命名空间 jt
// 需要实现命名空间的类提供 JTWrappable 协议扩展，并实现相关命名空间的对象方法（主要是扩展新的方法，如代码中的 testMethod 方法）
//
extension String: JTWrappable {}

// String 命名空间 jt 中的函数
extension JTKit where Base == String {
    public var testMethod: String {
        return base + "namespace"
    }
    public static func method1() {
        
    }
    
    public func method(str: String) -> String {
        return base + str
    }
}

class testVC: UIViewController {
    lazy var second: String = { return "second" }()
    func testMethod(){
        JTKit<String>.method1()
        _ = second.jt.testMethod
    }
}


// MARK: - 方式2

/// 类型协议
protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

struct NamespaceWrapper<T>: TypeWrapperProtocol {
    let wrappedValue: T
    init(value: T) {
        self.wrappedValue = value
    }
}

/// 命名空间协议
protocol NamespaceWrappable {
    associatedtype WrapperType
    var jx: WrapperType { get }
    static var jx: WrapperType.Type { get }
}

extension NamespaceWrappable {
    var jx: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    
    static var jx: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}


// users
extension UIColor: NamespaceWrappable {}

extension TypeWrapperProtocol where WrappedType == UIColor {
    
    /// 用自身颜色生成UIImage
    var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(wrappedValue.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}

extension String: NamespaceWrappable {}

extension TypeWrapperProtocol where WrappedType == String {

    /// 把自身作为日志打印
    func log() {
        print(wrappedValue)
    }
}
