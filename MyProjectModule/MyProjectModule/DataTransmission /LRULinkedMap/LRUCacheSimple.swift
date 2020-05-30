//
//  LRUCacheSimple.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/25.
//  Copyright © 2020 xinxin. All rights reserved.
// https://www.jianshu.com/p/1ff35be8a74f
/**
 - 双向链表+字典
  - 字典 存取
  - 链表 控制cache 容量
 
 - 链表操作
   - 修改节点 可以用 覆盖和 指向 两个思路。
   - 单链表用覆盖 双链表用指向。
 
  疑问：既然字典就可以0(1) 存取值，为何还需要链表？
  答：链表的作用主要用来控制容量。单独使用字典没有别的辅助，是无法控制哪些需要删除的。所以要用另一个容器去记录哪些需要删除。
     - 先尝试下数组(顺序存储结构)，数组读/取效率比较高，但插入/删除不好。
     - 栈的话(栈是一个有序线性表，只能在栈顶执行插入和删除), 不合适
     - 队列的特性(先进先出) 也不合适
     - 剩下的就是链表了(一种动态数据结构,链表的空间利用率比较高。插入和删除时比较容易，读取数据时比较麻烦<只能从head开始找>)
 
   - 总结： 链表既然查询很慢，但为什么还要双向链表实现。
       - 利用 HashMap 查询   O(1)
       - 利用 双向链表 操作数据 O(1)

 
 
 - 链表因为查询，只能从head开始。所以一般用head代表一个链表
 
 - self.head?.next = next 中的.next 一般解读为指向下一个节点
   - 单向链表
      1->2->nil
   - 双向链表
      1<->2<->3<->nil
   - 循环链表
    1<->2<->1 ?????
 
 */

import UIKit

class LRUListNode {
    // 添加key 为了绑定字典 方便删除字典中数据
    var key: Int
    var value: Int
    var next: LRUListNode?
    var prev: LRUListNode?
    
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCacheSimple {
    // 绑定一个 字典类型( key<Int> ) cache 用于存储
    private var cache = [Int: LRUListNode]()
    // 最大size
    private var max_size = 0
    // 当前size
    private var cur_size = 0
    // 头
    private var head: LRUListNode?
    // 尾
    private var tail: LRUListNode?
    
    init(_ capacity: Int) {
        max_size = capacity
    }
    
    // 取值 类型(value)
    public func get(_ key: Int) -> Int {
        // 判断key是否已经存在
        if let node = cache[key] {
            // 如果存在，将命中的值移动到头部
            moveToHead(node: node)
            // 返回值
            return node.value
        }
        return -1
    }
    
    // 存值 类型(key:value)
    public func put(_ key: Int, _ value: Int) {
        // 判断key是否已经存在
        if let node = cache[key] {
            // 更新节点的值
            node.value = value
            // 然后将命中的值移动到头部
            moveToHead(node: node)
        } else {
            // 转成节点
            let node = LRUListNode(key: key, value: value)
            // 添加节点到链表头部
            addToHeadNode(node: node)
            // 添加节点到字典
            cache[key] = node
    
            cur_size += 1
            // 如果超过设置的容量
            if cur_size > max_size {
                // 移除链表的尾部节点  移除字典中相应的值
                removeTail()
                cur_size -= 1
            }
        }
    }
    
    /// 添加节点到头部
    private func addToHeadNode(node: LRUListNode) {
        // 如果现在链表为空，直接赋值
        if self.head == nil {
            // 绑定 链表的地方
            self.head = node
            self.tail = node
        } else {
            // 取出旧头节点
            let temp = self.head!
            // 修改头节点为最新
            self.head = node
            // 新头节点的next指向下一个节点(旧头节点)
            self.head?.next = temp
            // 旧头节点的prev指向上一个节点(新头节点) <因为：双向链表还要指定下prev>
            temp.prev = self.head
        }
    }

    
    /// 移动到头部
    private func moveToHead(node: LRUListNode) {
        // 如果当前命中的就是head 不动 return
        if node === self.head {
            return
        }

        /// 取出(删除)将要移动的节点   因为node就是从当前链表取出的，地址一样无需while查找了比对了。而且因为是双向链表，可以更方便取出要删除的节点
        do {
            /*
             node = node.next 这个直接修改 node因为是不可变 行不通
             只能转化为 可变 的对象
             */
            
            // 取出 上一节点
            let prev = node.prev
            // 取出 下一节点
            let next = node.next
            // 上一个节点的next 指向 下一节点
//            prev?.next = next
            node.prev?.next = node.next
            // 下个节点不为nil时
            if next != nil {
                // 下一个节点的prev 指向 上一节点
//                next!.prev = prev
                node.next?.prev = node.prev
            } else {
                // 更新尾节点 (就是上一个节点, 也不需要回指了)
                self.tail = prev
            }
        }
        
        ///  将取出的节点 更新给 头节点
        do {
            // 取出头节点
            let origin = self.head
            // 更新头节点
            self.head = node
            // 新头节点next 指向旧头节点
            self.head?.next = origin
            // 旧头节点prev 指向新头节点
            origin?.prev = self.head
        }
    }


    
    /// 删除尾部
    // 当有返回值的方法未得到接收和使用时通常会出现⚠️，这个可以消除
    @discardableResult
    private func removeTail() -> LRUListNode? {
        // 先判断tail 是否存在
        if let tail = self.tail {
            // 从字典中移除
            cache.removeValue(forKey: tail.key)
            // 从链表中移除
            do {
//                self.tail?.prev?.next = nil 这个不对 因为只改变了next指向，没有更新tail的值

                // 尾部上一个节点替换当前尾部
                self.tail = tail.prev
                // 尾部下一个节点指向 nil
                self.tail?.next = nil
            }
            return tail
        }
        return nil
    }
}






//MARK:- LRU范型

class ListNodeB<T> {
    var prev: ListNodeB?
    var next: ListNodeB?
    var val: T
    var key: Int
    
    init(key: Int, val: T){
        self.key = key
        self.val = val
    }
}


class LRUCache<T> {
    var head: ListNodeB<Any>?
    var tail: ListNodeB<Any>?
    var max_size: Int = 0
    var cur_size: Int = 0
    var cache = [Int: ListNodeB<Any>]()
    
    init(size: Int) {
        self.max_size = size
    }
    
    func get(key: Int) -> T {
        if let node = cache[key] {
            moveToHeader(node: node)
            return node.val as! T
        }
        return -1 as! T
    }
    
    func moveToHeader(node: ListNodeB<Any>){
        if self.head === node {
            return
        }

        node.prev?.next = node.next
        if node.next != nil {
            node.next?.prev = node.prev
        }else{
            self.tail = node.prev
        }
        
        let temp = self.head
        self.head = node
        self.head?.next = temp
        temp?.prev = self.head
    }
    
    
    func put(key: Int, val: T){
        if let node = cache[key]{
            node.val = val
            moveToHeader(node: node)
        }else{
            let node = ListNodeB.init(key: key, val: val)
            addToHead(node: node as! ListNodeB<Any>)
            cache[key] = (node as! ListNodeB<Any>)

            cur_size += 1
            if cur_size > max_size{
                removeTail()
                cur_size -= 1
            }
        }
    }
    
    func addToHead(node: ListNodeB<Any>){
        if self.head == nil {
            self.head = node
            self.tail = node
        } else {
            let temp = self.head
            self.head = node
            self.head?.next = temp
            temp?.prev = self.head
        }
    }
    
    func removeTail(){
        if let tail = self.tail {
            cache.removeValue(forKey: tail.key)
            self.tail = tail.prev
            self.tail?.next = nil
        }
    }

}



//MARK:- 范型
/**
  从表面上看，这好像和泛型极其相似。Any 类型和泛型两者都能用于定义接受两个不同类型参数的函数。然而，理解两者之间的区别至关重要：泛型可以用于定义灵活的函数，类型检查仍然由编译器负责；而 Any 类型则可以避开 Swift 的类型系统 (所以应该尽可能避免使用)
 */

/// 类中泛型 - 实现一个栈
class YJKStack<T>: NSObject {
    //栈空间
    private var list:[T] = []
    
    //进栈
    public func push(item:T){
        list.append(item)
    }
    
    //出栈
    public func pop() -> T{
        return list.removeLast()
    }
}

/// 泛型类型约束
/**
 class YJKProtocolStack<T: A&B>  须实现多个协议的话，用 & 符号链接就好啦。
 */

class YJKProtocolStack<T: A>: NSObject {
    //栈空间
    private var list:[T] = []
    
    //进栈
    public func push(item:T){
        list.append(item)
    }
    
    //出栈
    public func pop() -> T{
        return list.removeLast()
    }
}

protocol A {}

protocol B {}
