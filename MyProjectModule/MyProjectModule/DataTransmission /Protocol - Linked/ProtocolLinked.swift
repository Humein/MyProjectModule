//
//  ProtocolLinked.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/30.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

protocol ChainListAble {
    associatedtype T: Equatable
    // 打印
    var description: String{get}
    // 数量
    var count: Int{get}
    
    /// 插入
    func insertToHead(node: Node<T>)
    func insertToHead(value: T)
    func insertToTail(node: Node<T>)
    func insertToTail(value: T)
    func insert(node: Node<T>, afterNode: Node<T>) -> Bool
    func insert(value: T, afterNode: Node<T>) -> Bool
    func insert(node: Node<T>, beforNode: Node<T>) -> Bool
    func insert(value: T, beforNode: Node<T>) -> Bool
    
    /// 删除(默认第一个符合条件的)
    @discardableResult func delete(node: Node<T>) -> Bool
    @discardableResult func delete(value: T) -> Bool
    @discardableResult func delete(index: Int) -> Bool
    //func delete(fromIndex: Int, toIndex: Int) -> Bool
    //func deleteAll()
    
    /// 查找(默认第一个符合条件的)
    func find(value: T) -> Node<T>?
    func find(index: Int) -> Node<T>?
    
    /// 判断结点是否在链表中
    func isContain(node: Node<T>) -> Bool
}

/// [值类型不能在递归里调用](https://www.codetd.com/article/40263)，因此Node类型只能是class而不是struct
// 有些时候你只能使用类而不能使用结构体，那就是递归里
// struct报错：Value type 'Node' cannot have a stored property that recursively contains it
class Node<T: Equatable> {
    var value: T
    var next: Node?
    
    /// 便利构造方法
    ///
    /// - Parameter value: value
    convenience init(value: T) {
        self.init(value: value, next: nil)
    }
    
    /// 默认指定初始化方法
    ///
    /// - Parameters:
    ///   - value: value
    ///   - next: next
    init(value: T, next: Node?) {
        self.value = value
    }
    
    // 销毁函数
    deinit {
        print("\(self.value) 释放")
    }
}

extension Node {
    /// 返回当前结点到链表尾的长度
    var count: Int {
        var idx: Int = 1
        var node: Node? = self
        while node?.value != nil {
            node = node?.next
            idx = idx + 1
        }
        return idx
    }
}

class SingleChainList: ChainListAble {
    typealias T = String
    // 哨兵结点，不存储数据
    private var dummy: Node = Node.init(value: "")
}
extension SingleChainList {
    var description: String {
        var description: String = ""
        var tempNode = self.dummy
        while let nextNode = tempNode.next {
            description = description + " " + nextNode.value
            tempNode = nextNode
        }
        return description
    }
    var count: Int {
        var count: Int = 0
        var tempNode = self.dummy
        while let nextNode = tempNode.next {
            count = count + 1
            tempNode = nextNode
        }
        return count
    }
    
    /// 在头部插入值
    ///
    /// - Parameter value: value
    func insertToHead(value: T) {
        let node: Node = Node.init(value: value)
        self.insertToHead(node: node)
    }
    /// 在头部插入结点
    ///
    /// - Parameter node: node
    func insertToHead(node: Node<T>) {
        node.next = self.dummy.next
        self.dummy.next = node
    }
    /// 在尾部插入值
    ///
    /// - Parameter value: value
    func insertToTail(value: T) {
        let node: Node = Node.init(value: value)
        self.insertToTail(node: node)
    }
    /// 在尾部插入结点
    ///
    /// - Parameter node: node
    func insertToTail(node: Node<T>) {
        var tailNode: Node = self.dummy
        while let nextNode = tailNode.next {
            tailNode = nextNode
        }
        tailNode.next = node
    }
    /// 在指定结点的后面插入新value
    ///
    /// - Parameters:
    ///   - value: 新值
    ///   - afterNode: 指定结点
    /// - Returns: true or false
    func insert(value: T, afterNode: Node<T>) -> Bool {
        let node: Node = Node.init(value: value)
        return self.insert(node: node, afterNode: afterNode)
    }
    /// 在指定结点的后面插入新结点
    ///
    /// - Parameters:
    ///   - value: 新结点
    ///   - afterNode: 指定结点
    /// - Returns: true or false
    func insert(node: Node<T>, afterNode: Node<T>) -> Bool {
        guard self.isContain(node: afterNode) else {
            return false
        }
        node.next = afterNode.next
        afterNode.next = node
        return true
    }
    /// 在指定结点的前面插入新value(双向链表实现这种插入方式速度比单向链表快)
    ///
    /// - Parameters:
    ///   - value: 新值
    ///   - beforNode: 指定结点
    /// - Returns: true or false
    func insert(value: T, beforNode: Node<T>) -> Bool {
        let node: Node = Node.init(value: value)
        return self.insert(node: node, beforNode: beforNode)
    }
    /// 在指定结点的前面插入新结点(双向链表实现这种插入方式速度比单向链表快)
    ///
    /// - Parameters:
    ///   - node: 新结点
    ///   - beforNode: 指定结点
    /// - Returns: true or false
    func insert(node: Node<T>, beforNode: Node<T>) -> Bool {
        var tempNode: Node = self.dummy
        while let nextNode = tempNode.next {
            if nextNode === beforNode {
                node.next = beforNode
                tempNode.next = node
                return true
            }
            tempNode = nextNode
        }
        return false
    }
    /// 删除指定value的结点
    ///
    /// - Parameter value: value
    /// - Returns: true or false
    func delete(value: T) -> Bool {
        var tempNode: Node = self.dummy
        while let nextNode = tempNode.next {
            // 此处判断 == 是否合理
            if nextNode.value == value {
                tempNode.next = nextNode.next
                return true
            }
            tempNode = nextNode
        }
        return false
    }
    /// 删除指定的结点
    ///
    /// - Parameter node: node
    /// - Returns: true or false
    func delete(node: Node<T>) -> Bool {
        var tempNode = self.dummy
        while let nextNode = tempNode.next {
            if nextNode === node {
                tempNode.next = nextNode.next
                return true
            }
            tempNode = nextNode
        }
        return false
    }
    /// 删除指定下标的结点
    ///
    /// - Parameter index: index
    /// - Returns: true or false
    func delete(index: Int) -> Bool {
        var idx: Int = 0
        var tempNode: Node = self.dummy
        while let nextNode = tempNode.next {
            if index == idx {
                tempNode.next = nextNode.next
                return true
            }
            tempNode = nextNode
            idx = idx + 1
        }
        return false
    }
    
    /// 查找指定值的node
    ///
    /// - Parameter value: value
    /// - Returns: node
    func find(value: T) -> Node<T>? {
        var tempNode = self.dummy
        while let nextNode = tempNode.next {
            if nextNode.value == value {
                return nextNode
            }
            tempNode = nextNode
        }
        return nil
    }
    /// 查找指定下标的结点
    ///
    /// - Parameter index: index
    /// - Returns: node
    func find(index: Int) -> Node<T>? {
        var idx: Int = 0
        var tempNode: Node = self.dummy
        while let nextNode = tempNode.next {
            if index == idx {
                return nextNode
            }
            tempNode = nextNode
            idx = idx + 1
        }
        return nil
    }
    /// 判断给定的链表是否在链表中
    ///
    /// - Parameter node: node
    /// - Returns: true or false
    func isContain(node: Node<T>) -> Bool {
        var tempNode = self.dummy.next
        while tempNode != nil {
            if tempNode === node {
                return true
            }
            tempNode = tempNode?.next
        }
        return false
    }
    /// 单向链表反转：方式一非递归实现
    ///
    /// - Parameter chainList: 源链表
    /// - Returns: 反转后的链表
    func reverseList() {
        var prevNode: Node<String>? = self.dummy.next
        var curNode: Node<String>? = prevNode?.next
        var tempNode: Node<String>? = curNode?.next
        prevNode?.next = nil
        while curNode != nil {
            tempNode = curNode?.next
            curNode?.next = prevNode
            prevNode = curNode
            curNode = tempNode
        }
        self.dummy.next = prevNode
    }
    /// 单向链表反转：方式二递归实现
    ///
    /// - Parameter chainList: 源链表
    /// - Returns: 反转后的链表
    func reverseListUseRecursion(head: Node<T>?, isFirst: Bool) {
        var tHead = head
        if isFirst {
            tHead = self.dummy.next
        }
        guard let rHead = tHead else { return }
        if rHead.next == nil {
            self.dummy.next = rHead
            return
        }
        else {
            self.reverseListUseRecursion(head:rHead.next, isFirst: false)
            rHead.next?.next = rHead
            rHead.next = nil
        }
    }
}

class LinkedListVC: UIViewController {
    var chainList: SingleChainList = SingleChainList.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化链表
        for i in 0..<10 {
            let node: Node = Node.init(value: String(i))
            chainList.insertToTail(node: node)
        }
        // 查找结点
        for i in 0..<12 {
            if let find: Node = chainList.find(index: i) {
                debugPrint("find = \(find.value)")
            }
            else {
                debugPrint("not find idx = \(i)")
            }
        }
        // 删除结点
        if chainList.delete(index: 10) {
            debugPrint("删除 index = \(index)成功")
        }
        else {
            debugPrint("删除 index = \(index)失败")
        }
        // 打印结点value信息
        debugPrint(chainList.description)
        // 打印结点个数
        debugPrint(chainList.count)
        // 单向链表反转
        chainList.reverseList()
        // 打印结点value信息
        debugPrint(chainList.description)
        // 单向链表反转
        chainList.reverseListUseRecursion(head: nil, isFirst: true)
        // 打印结点value信息
        debugPrint(chainList.description)
    }
}

