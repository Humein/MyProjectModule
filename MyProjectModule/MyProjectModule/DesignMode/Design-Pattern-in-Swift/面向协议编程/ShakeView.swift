//
//  shakeView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/3.
//  Copyright © 2019 xinxin. All rights reserved.
/*
   Swift的 POP 是使用了继承的思想，它模拟了多继承关系，实现了代码的跨父类复用，同时也不存在 is-a 关系。swift中主类和 extension扩展类 的协同工作，保留了 在主类中定义方法 在所继承的类中进行实现的特性，又新增了在 extension拓展类 中定义并实现的方法在任何继承自此协议的类中可以任意调用，从而实现组件化编程。
*/
import UIKit

class FoodImageView: UIImageView, ShakeDelegate, CloseDelegate{

    func shake() {
        print("shake")
    }
}

class ActionButton: UIButton, ShakeDelegate, CloseDelegate{
    
    func shake() {
        print("shake")
    }
}

class ActionObject: NSObject, ShakeDelegate, CloseDelegate{
    
    func shake() {
        print("shake")
    }
}

/*
      以上优化有两种方案
      1: 使用继承(抽象出一个View ActionButton,FoodImageView 都会继承它) /  分类(UIView)
         缺点：
             可读性很差了。例如，对于 foodImageView 和 actionButton 来说，你看不出来任何抖动的意图。整个类里面没有任何东西能告诉你它需要抖动。这样表意不明确，因为别处可能会随机存在一个抖动函数，你甚至不知道它是从哪里来的。
      2: 使用协议
 
 
个人理解：
       使用协议代替继承 可以更好的实现功能(组建)的 插拔性。 避免一个类其实只要一个功能情况下，也要继承着多个功能模块，同时基类中功能会慢慢越来越臃肿。 而且还可以将功能抽象的添加到不同类中(View和VC 继承同一种协议)
       基类的作用是统一管理，统一风格，便于编码，有更多的额外的附加功能的话，建议使用Protocol 或 Category，这样移植性强，便于管理与扩展，不至于牵一发而动全身。
 */

//MARK: - 1: 使用继承
extension UIView {
    func ex_shake() {
        print("ex_shake")
    }
}


//MARK: - 2: 使用协议
protocol ShakeDelegate { }
// 默认实现 where Self: UIView 限制调用类型
extension ShakeDelegate where Self: UIView {
    func protocol_shake() {
        print("protocol_shake")
    }
}

protocol CloseDelegate { }
// 默认实现 
extension CloseDelegate {
    func protocol_close() {
        print("protocol_close")
    }
}


//MARK: - 3: 使用协议 代替工厂模式
protocol InitObjectProtocol {
    func initObject() -> Any
}

class ButtonA: UIButton, InitObjectProtocol{
    func initObject() -> Any {
        let button = UIButton.init()
        return button
    }
}

class UIViewA: UIView, InitObjectProtocol{
    func initObject() -> Any {
        let view = UIView.init()
        return view
    }
}

class ProtocolHeler: NSObject {
    var dele: InitObjectProtocol? = nil

}
