//
//  shakeView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/3.
//  Copyright © 2019 xinxin. All rights reserved.

import UIKit

/**
  - 对于重复功能的可做以下处理
    - 基类
      -  抽象出一个基类； A ,B,C 继承它
          缺点：
           - 可读性很差，例如，对于 A/B/C 来说，你看不出来任何feature的行为, 个类里面没有任何东西能告诉你它需要feature。这样表意不明确，因为别处可能会随机存在一个feature，你甚至不知道它是从哪里来的
           - 随着业务增加，基类会越来越臃肿。
    - 分类
      - 对他们的基类比如UIView进行扩展, 避免不同类型的feature都融合在一个类中
        缺点:
        对于不同的类型Object就无法适用
    - 协议
      - 功能具有插拔性
      - 适用场景广泛
      - 避免一个类其实只要一个功能情况下，也要继承着多个功能模块
        缺点:
        OC的协议没有默认实现
 
 - 已有的功能添加新功能
   - 引入对象 <装饰者/适配器>
   - AOP
     - 改动最小，神不知鬼不觉。 方法甚至可以不出现在 Controller 里面，缺点: 这也导致代码管理上比较松散
        - CoreText 复制粘贴 - UIGestureRecognizer 添加 UITouch 对象
   - 继承
   - 分类 + RunTime
     - 代码侵入少，同时方法调用逻辑也会出现在合适的地方。缺点：不能复用新加功能，比如下列例子中的非Object对象
     - NSObject+FBKVOController，就通过 associated object 的方式给每个 NSObject 对象添加了一个功能属性
 
   - 协议
     - 利用Swift协议默认实现特性 代替继承/分类添加功能，避免继承的臃肿和分类的移植性差
     - 使用协议代替继承 可以更好的实现功能(组建)的 插拔性。    避免一个类其实只要一个功能情况下，也要继承着多个功能模块，同时基类中功能会慢慢越来越臃肿。 而且还可以将功能抽象的添加到不同类中(View和VC 继承同一种协议)
     - 基类的作用是统一管理，统一风格，便于编码，有更多的额外的附加功能的话，建议使用Protocol 或 Category，这样移植性强，便于管理与扩展，不至于牵一发而动全身

 */


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



//MARK: - 1: 基类
class BaseObject{
    func base_shake() {
        print("base_shake")
    }
}

//MARK: - 2: 扩展
extension UIView {
    func ex_shake() {
        print("ex_shake")
    }
}

extension ActionObject {
    func ex_shake() {
        print("ex_shake")
    }
}

//MARK: - 3: 协议
protocol ShakeDelegate { }
// 默认实现 where  限制类型
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


//MARK: - 4: 协议模拟工厂模式 参考 FactoryObject
protocol InitObjectProtocol {
    func initObject() -> Any
    var abutton : UIButton? { get set }

}

class ButtonA: UIButton, InitObjectProtocol{
    var abutton: UIButton?
        
    func initObject() -> Any {
        let button = UIButton.init()
        return button
    }
}

class UIViewA: UIView, InitObjectProtocol{
    var abutton: UIButton?
    
    func initObject() -> Any {
        let view = UIView.init()
        return view
    }
}

class ProtocolHeler: NSObject {
    var dele: InitObjectProtocol? = nil
    
    init(_ model: Any) {
        let view = dele?.initObject()
        let button = dele?.initObject()
        
        print(view.debugDescription)
        print(button.debugDescription)
    }
    
}
