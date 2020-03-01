//
//  DoublyLinkedList.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/28.
//  Copyright © 2020 xinxin. All rights reserved.
//


/// 双向链表demo

import UIKit
/// 结点数据结构
class ListNode<T> {
    var value: T
    weak var previous: ListNode?
    var next: ListNode?
    init(value: T) {
        self.value = value
        self.previous = nil
        self.next = nil
    }
}

/// 双向链表的数据结
class LinkList<T> {
    typealias Node = ListNode<T>
    
    var head: Node?
    
    var first: Node? {
        return head
    }
    
    var last: Node? {
        guard var node = head else { return nil }
        while let next = node.next {
            node = next
        }
        return node
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var count: Int {
        guard var node = head else { return 0 }
        var cut = 0
        while let next = node.next {
            node = next
            cut += 1
        }
        return cut
    }
    
    // 查找结点
    func getNode(at index: Int) -> Node? {
        if index == 0 { return head }
        if index > count { return nil }
        var node = head!.next
        for _ in 1..<index {
            node = node?.next
            if node == nil {
                // return nil
                break
            }
        }
        return node
    }
    
    // 增加结点
    func append(_ value: T) {
        let newNode = Node(value: value)
        if let last = last {
            last.next = newNode
            newNode.previous = last
        } else {
            //空链表
            head = newNode
        }
    }

    func insertHead(_ value: T) {
        let newNode = Node(value: value)
        if var head = head {
            newNode.next = head
            head.previous = newNode
            head = newNode
        } else {
            head = newNode
        }
    }
    
    func insert(_ value: T ,atIndex index: Int) {
        if index < 0 {
            return
        }
        let newNode = Node(value: value)
        if count == 0 {
            head = newNode
        } else {
            if index == 0 {
                newNode.next = head
                head?.previous = newNode
                head = newNode
            } else {
                if index > count {
                    return
                }
                
                let nodeP = getNode(at: index - 1)
                let nodeN = nodeP?.next
                
                nodeP?.next = newNode
                newNode.previous = nodeP
                
                nodeN?.previous = newNode
                newNode.next = nodeN
                
            }
        }
    }

    // 删除结点
    func removeAll() {
        head = nil
    }
    
    func removeLast() -> T? {
        if isEmpty { return nil }
         return removeNode(atIndex: count)
    }
    
    func removeNode(node: Node) -> T? {
        guard head != nil else {
            return nil
        }
        
        let prev = node.previous
        let next = node.next
        
        //当某结点 prev 为空时，即为 head 结点
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev // 此时 prev 仍旧为optional值，
        
        //清空node信息
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    func removeNode(atIndex index: Int) -> T? {
        if head == nil {
            return nil
        }
        
        let node = getNode(at: index)
        let prev = node?.previous
        let next = node?.next
        //当某结点 prev 为空时，即为 head 结点
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        //清空node信息
        node?.previous = nil
        node?.next = nil
        return node?.value
    }

}



class DoublyLinkedList: NSObject {

    override init() {
        let node = LinkList<Any>.init()
        let node1 = ListNode.init(value: 1)
        let node2 = ListNode.init(value: 2)
        let node3 = ListNode.init(value: 3)
        let node4 = ListNode.init(value: 4)

        
        node.append(node1)
        node.append(node2)
        node.append(node3)
        node.append(node4)


        /// swift 链式编程
        let person = Person.init { (person) in
            _ = person.name("Tom").age(12).sex("man")
        }
        print(person.name!,person.sex!,person.age!)  //输出 Tom man 12
        
        ///
        let aC = AChain.init("A")
        let bC = BChain.init("B")
        let cC = CChain.init("C")
        let chain = LinkChain.init()
        chain.initWith { (link) in
            _ = link.next(aC).next(bC).next(cC)
        }
        
        print(chain.getChainList())
        print(chain.headerNode as Any)
        print(chain.lastNode as Any)


    }

}


/// 自定义双链表
class LinkChain: Any{
    var headerNode: LinkChain?
    var lastNode: LinkChain? {
        guard var node = headerNode else { return nil }
        while let next = node.nextChain {
            node = next
        }
        return node
    }
    var prevChain: LinkChain?
    var nextChain: LinkChain?
    
    func initWith(closure: (LinkChain) -> Void) {
        closure(self)
    }
    
    
    func next(_ node: LinkChain) -> LinkChain {
        self.nextChain = node
        if let last = lastNode {
            last.nextChain = node
            node.prevChain = last
        } else {
            //空链表
            headerNode = node
        }
        return self
    }
    
    func getChainList() -> [LinkChain]{
        var nodes = [LinkChain]()
        var temp = self.headerNode
        while temp != nil {
            nodes.append(temp!)
            temp = temp!.nextChain
        }
        return nodes
    }
    
}


class AChain: LinkChain {
    var name: String?
    
    init(_ name: String) {
        self.name = name
    }
}

class BChain: LinkChain {
    var name: String?
    
    init(_ name: String) {
        self.name = name
    }
}

class CChain: LinkChain {
    var name: String?
    
    init(_ name: String) {
        self.name = name
    }
}



//MARK: -swift 链式编程
class Person {
    var name: String?
    var sex: String?
    var age: Int?
    
    init(closure: (Person) -> Void) {
        closure(self)
    }
    
    func name(_ name: String) -> Person {
        self.name = name
        return self
    }
    
    func sex(_ sex: String) -> Person {
        self.sex = sex
        return self
    }
    
    func age(_ age: Int) -> Person {
        self.age = age
        return self
    }
}
