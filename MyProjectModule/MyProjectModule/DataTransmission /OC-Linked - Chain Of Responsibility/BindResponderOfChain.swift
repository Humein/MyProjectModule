//
//  BindingResponderOfChain.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/3/1.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class BindResponderOfChain: ResponderDelegate{
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
        var temp = self
        while (temp.prevChain != nil) {
            if (temp.prevChain == nil) {
                break
            }
            temp = temp.prevChain!
        }
        temp.responseEvent(eventType: eventType, with: item )
    }

    func responseEvent(eventType: NSInteger, with item: BlockModel) {
        print("log: \(type(of: self))" + "\(eventType)" + "\(item)")
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
    
    init(_ name: String) {
        self.name = name
    }
    
    override func responseEvent(eventType: NSInteger, with item: BlockModel) {
        super.responseEvent(eventType: eventType, with: item)
        item.stateBlock = { (item) -> () in
            if let mode = item as? BlockModel {
                print(mode.title as Any)
            }
        }
        self.nextChain?.responseEvent(eventType: eventType, with: item)

    }
}

class BChain: BindResponderOfChain{
    var name: String?
    
    init(_ name: String) {
        self.name = name
    }
    
    override func responseEvent(eventType: NSInteger, with item: BlockModel) {
        super.responseEvent(eventType: eventType, with: item)
        item.stateBlock = { (item) -> () in
            if let mode = item as? BlockModel {
                print(mode.title as Any)
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
    
    init(_ name: String) {
        self.name = name
    }

    override func responseEvent(eventType: NSInteger, with item: BlockModel) {
        super.responseEvent(eventType: eventType, with: item)
        item.title = "CChain"
        item.stateBlock?(item)
        self.nextChain?.responseEvent(eventType: eventType, with: item)

    }
}


