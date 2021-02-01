//
//  AbstractView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/22.
//  Copyright © 2019 xinxin. All rights reserved.
//
/*
   协议场景
 - 1: 代理模式 ---- SDTouchAddressBookManagerProtocol  [Swift 代理模式](https://www.jianshu.com/p/1e133e3e3b91)
 
 - 2: 协议提供默认的实现 ---- AbstractViewProtocol
 
 - 3: 抽象组合(使用协议代替继承 可以更好的实现功能(组建)的 插拔性)
      ShakeView  [Swift面向协议编程(POP)](https://juejin.im/post/5d68c722f265da03a0498e0c)
      [Swift 中的面向协议编程：引言](https://swift.gg/2019/09/05/protocol-oriented-programming/)
 
      我们经常会遇到如下场景:
       假设我们有一个ViewController，它继承自UIViewController，我们向其新添加一个方法
   customMethod：这个时候我们有另外一个继承自UITableViewController的OtherViewController,同样也需要向其添加方法customMethod
        这里就存在一个问题:很难在不同继承关系的类里共用代码。
 
       我们的关注点customMethod位于两条继承链 UIViewController -> ViewCotroller 和 UIViewController -> UITableViewController -> AnotherViewController 的横切面上。面向对象是一种不错的抽象方式，但是肯定不是最好的方式。它无法描述两个不同事物具有某个相同特性这一点。在这里，特性的组合要比继承更贴切事物的本质
 
    有如下几种方法解决:
    - Copy & Paste
    这是一个糟糕的解决方案,我们应该尽量避免这种做法。

    - BaseViewController
    在一个继承自 UIViewController 的 BaseViewController 上添加需要共享的代码,或者在 UIViewController 上添加 extension。这是目前很多人常用的解决方法,但是如果不断这么做，会让所谓的BaseViewController 很快变成垃圾堆。职责不明确，任何东西都能扔进 Base，你完全不知道哪些类走了 Base，而这个“超级类”对代码的影响也会不可预估。

    - 依赖注入
    通过外界传入一个带有 customMethod的对象，用新的类型来提供这个功能。这是一个稍好的方式，但是引入额外的依赖关系，可能也是我们不太愿意看到的。

    - 多继承
    当然，Swift是不支持多继承的。不过如果有多继承的话，我们确实可以从多个父类进行继承，并将customMethod添加到合适的地方,但这又会带来其他问题。
 
    - POP

 * 总的来说,面向协议编程(POP) 带来的好处如下:

 - 结构体、枚举等值类型也可以使用
 - 以继承多个协议，弥补 swift 中类单继承的不足
 - 增强代码的可扩展性，减少代码的冗余
 - 让项目更加组件化，代码可读性更高
 - 让无需的功能代码组成一个功能块，更便于单元测试。
 
 
 * 协议的特性及使用
- 协议扩展
- 协议继承
- 协议的组合

 */

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
        print("drink......extension")
    }
    // 正向传值
    func eat(_ param: String) {
        print("eat......\(param)")
    }
}

