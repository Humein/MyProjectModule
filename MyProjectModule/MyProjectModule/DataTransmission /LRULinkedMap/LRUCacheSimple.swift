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

class ListNode {
    var key: Int
    var value: Int
    var next: ListNode?
    var prev: ListNode?
    
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCacheSimple {
    private var cache = [Int: ListNode]()
    // 最大size
    private var max_size = 0
    // 当前size
    private var cur_size = 0
    // 头
    private var head: ListNode?
    // 尾
    private var tail: ListNode?
    
    init(_ capacity: Int) {
        max_size = capacity
    }
    
    public func get(_ key: Int) -> Int {
        if let node = cache[key] {
            moveToHead(node: node)
            return node.value
        }
        return -1
    }
    
    public func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node: node)
        } else {
            let node = ListNode(key: key, value: value)
            
            addNode(node: node)
            cache[key] = node
            
            cur_size += 1
            if cur_size > max_size {
                removeTail()
                cur_size -= 1
            }
        }
    }
    
    /// 添加节点到头部
    private func addNode(node: ListNode) {
        // 如果现在链表为空，直接赋值
        if self.head == nil {
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
    private func moveToHead(node: ListNode) {
        // 如果当前命中的就是head 不动 return
        if node === self.head {
            return
        }

        /// 取出(删除)将要移动的节点
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
            prev?.next = next
            // 下个节点不为nil时
            if next != nil {
                // 下一个节点的prev 指向 上一节点
                next!.prev = prev
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
    private func removeTail() -> ListNode? {
        // 先判断tail 是否存在
        if let tail = self.tail {
            // 从字典中移除
            cache.removeValue(forKey: tail.key)
            // 尾部上一个节点替换当前尾部 
            self.tail = tail.prev
            //
            self.tail?.next = nil
            return tail
        }
        return nil
    }
}



