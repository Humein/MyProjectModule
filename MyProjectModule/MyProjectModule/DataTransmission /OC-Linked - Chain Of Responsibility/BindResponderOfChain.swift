//
//  BindingResponderOfChain.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/3/1.
//  Copyright © 2020 xinxin. All rights reserved.
//
/**
 为什么不用 数组？？？？
  - self.nextChain是关键，用数组的话怎么查找数组中的下一个。你需要向下传递的时候。需要拿到数组的下一个(下标)。数组还有越界的风险
    而链表用self.nextChain就可以了.
 */
import UIKit

class BindResponderOfChain: UIView, ResponderDelegate{
    var headerNode: BindResponderOfChain?
    var lastNode: BindResponderOfChain? {
        guard var node = headerNode else { return nil }
        while let next = node.nextChain {
            node = next
        }
        return node
    }
    var prevChain: BindResponderOfChain?
    var nextChain: BindResponderOfChain?
    
    func initWith(closure: (BindResponderOfChain) -> Void) {
        closure(self)
    }
    
    func next(_ node: BindResponderOfChain) -> BindResponderOfChain {
        self.nextChain = node
        if let last = lastNode {
            last.nextChain = node
            node.prevChain = last
        } else {
            headerNode = node
        }
        return self
    }
    
    func getChainList() -> [BindResponderOfChain]{
        var nodes = [BindResponderOfChain]()
        var temp = self.headerNode
        while temp != nil {
            nodes.append(temp!)
            temp = temp!.nextChain
        }
        return nodes
    }
    
    func cutOffChain() -> Bool{
        return false
    }
    
    func sendEvent(eventType: NSInteger, with item: BlockModel) {
        var tempPrev = self
//        var tempNext = self
        
        while tempPrev.prevChain != nil {
            if tempPrev.prevChain == nil {
                break
            }
            tempPrev = tempPrev.prevChain!
        }
        /// header 发送消息就行了。后续的通过在每个node的responder中node.next 调用
        tempPrev.responseEvent(eventType: eventType, with: item )
        
        /**
         前后 这样 self.nextChain?.responseEvent 不用在每个类中写了 但就不能装饰了
        self.responseEvent(eventType: eventType, with: item)
        while tempPrev.prevChain != nil {
            tempPrev.prevChain?.responseEvent(eventType: eventType, with: item)
            tempPrev = tempPrev.prevChain!
        }
        while tempNext.nextChain != nil {
            tempNext.nextChain?.responseEvent(eventType: eventType, with: item)
            tempNext = tempNext.nextChain!
        }
      */
        
    }

    func responseEvent(eventType: NSInteger, with item: BlockModel) {
        print("log: \(type(of: self))" + "\(eventType)" + "\(String(describing: item.title))")
    }
}

protocol ResponderDelegate {}
//extension ResponderDelegate where Self: BindResponderOfChain {
//    func responseEvent(eventType: NSInteger, with item: Any){
//        self.nextChain?.responseEvent(eventType: eventType, with: item)
//        print("deinit: \(type(of: self))" + "\(eventType)" + "\(item)")
//    }
//}

class AChain: BindResponderOfChain {
    var name: String?
    /// 构造器
    init(_ name: String,_ frame: CGRect) {
        self.name = name
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func responseEvent(eventType: NSInteger, with item: BlockModel) {
        super.responseEvent(eventType: eventType, with: item)
        item.stateBlock = { (item) -> () in
            if let mode = item as? BlockModel {
//                print(mode.title as Any)
            }
        }
        self.nextChain?.responseEvent(eventType: eventType, with: item)
    }
}

class BChain: BindResponderOfChain{
    var name: String?
    
    init(_ name: String,_ frame: CGRect) {
        self.name = name
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func responseEvent(eventType: NSInteger, with item: BlockModel) {
        super.responseEvent(eventType: eventType, with: item)
        item.stateBlock = { (item) -> () in
            if let mode = item as? BlockModel {
//                print(mode.title as Any)
            }
        }
        self.nextChain?.responseEvent(eventType: eventType, with: item)
    }
    
    func actionChian(eventType: NSInteger, with item: BlockModel) {
        self.sendEvent(eventType: eventType, with: item)
    }
}

class CChain: BindResponderOfChain{
    var name: String?
    
    init(_ name: String,_ frame: CGRect) {
        self.name = name
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func responseEvent(eventType: NSInteger, with item: BlockModel) {
        super.responseEvent(eventType: eventType, with: item)
        item.title = "CChain"
        item.stateBlock?(item)
        self.nextChain?.responseEvent(eventType: eventType, with: item)
    }
}


