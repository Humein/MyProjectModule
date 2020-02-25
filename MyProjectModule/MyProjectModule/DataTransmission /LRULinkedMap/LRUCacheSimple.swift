//
//  LRUCacheSimple.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/25.
//  Copyright © 2020 xinxin. All rights reserved.
//

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
        if self.head == nil {
            self.head = node
            self.tail = node
        } else {
            let temp = self.head!
            self.head = node
            self.head?.next = temp
            temp.prev = self.head
        }
    }
    
    /// 移动到头部
    private func moveToHead(node: ListNode) {
        if node === self.head {
            return
        }
        
        let prev = node.prev
        let next = node.next
        prev?.next = next
        if next != nil {
            next!.prev = prev
        } else {
            self.tail = prev
        }
        let origin = self.head
        self.head = node
        self.head?.next = origin
        origin?.prev = self.head
    }
    
    /// 删除尾部
    @discardableResult
    private func removeTail() -> ListNode? {
        if let tail = self.tail {
            cache.removeValue(forKey: tail.key)
            self.tail = tail.prev
            self.tail?.next = nil
            return tail
        }
        return nil
    }
}



