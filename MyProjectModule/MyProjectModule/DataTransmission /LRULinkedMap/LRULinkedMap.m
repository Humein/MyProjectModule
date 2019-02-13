//
//  LRULinkedMap.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/29.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "LRULinkedMap.h"
#import <pthread.h>


@implementation LinkedMapNode

@end


@implementation LRULinkedMap
- (instancetype)init {
    self = [super init];
    _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    _releaseOnMainThread = NO;
    _releaseAsynchronously = YES;
    return self;
}

- (void)dealloc {
    CFRelease(_dic);
}

- (void)insertNodeAtHead:(LinkedMapNode *)node {
    // 字典保存链表节点node
    CFDictionarySetValue(_dic, (__bridge const void *)(node->_key), (__bridge const void *)(node));
    _totalCost += node->_cost;
    _totalCount++;
    if (_head) {
        // 存在链表头，取代当前表头
        node->_next = _head;
        _head->_prev = node;
        // 重新赋值链表表头临时变量_head
        _head = node;
    } else {
        // 不存在链表头
        _head = _tail = node;
    }
}

- (void)bringNodeToHead:(LinkedMapNode *)node {
    if (_head == node) return;
    
    if (_tail == node) {
        // 把node指向的上一个节点赋值给链表尾节点
        _tail = node->_prev;
        // 把链表尾节点指向的下一个节点赋值nil
        _tail->_next = nil;
    } else {
        //   提出nodel节点
        // 把node指向的上一个节点赋值給node指向的下一个节点node指向的上一个节点
        node->_next->_prev = node->_prev;
        // 把node指向的下一个节点赋值给node指向的上一个节点node指向的下一个节点
        node->_prev->_next = node->_next;
    }
        // 接入nodel节点
    // 把链表头节点赋值给node指向的下一个节点
    node->_next = _head;
    // 把node指向的上一个节点赋值nil
    node->_prev = nil;
    // 把节点赋值给链表头节点的指向的上一个节点
    _head->_prev = node;
    _head = node;
}

- (void)removeNode:(LinkedMapNode *)node {
    // 从字典中移除node
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(node->_key));
    // 减掉总内存消耗
    _totalCost -= node->_cost;
    // // 总缓存数-1
    _totalCount--;
    // 重新连接链表
    if (node->_next) node->_next->_prev = node->_prev;
    if (node->_prev) node->_prev->_next = node->_next;
    if (_head == node) _head = node->_next;
    if (_tail == node) _tail = node->_prev;
}

// 移除尾节点(如果存在)
- (LinkedMapNode *)removeTailNode {
    if (!_tail) return nil;
    // 拷贝一份要删除的尾节点指针
    LinkedMapNode *tail = _tail;
    // 移除链表尾节点
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(_tail->_key));
    // 减掉总内存消耗
    _totalCost -= _tail->_cost;
    // 总缓存数-1
    _totalCount--;
    if (_head == _tail) {
        // 清除节点，链表上已无节点了
        _head = _tail = nil;
    } else {
        // 设倒数第二个节点为链表尾节点
        _tail = _tail->_prev;
        _tail->_next = nil;
    }
    // 返回完tail后_tail将会释放
    return tail;
}

// 移除所有缓存
- (void)removeAll {
    // 清空内存开销与缓存数量
    _totalCost = 0;
    _totalCount = 0;
    // 清空头尾节点
    _head = nil;
    _tail = nil;
    
    if (CFDictionaryGetCount(_dic) > 0) {
        // 拷贝一份字典
        CFMutableDictionaryRef holder = _dic;
        // 重新分配新的空间
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        
        if (_releaseAsynchronously) {
            // 异步释放缓存
            dispatch_queue_t queue = _releaseOnMainThread ? dispatch_get_main_queue() : nil;
            dispatch_async(queue, ^{
                CFRelease(holder); // hold and release in specified queue
            });
        } else if (_releaseOnMainThread && !pthread_main_np()) {
            // 主线程上释放缓存
            dispatch_async(dispatch_get_main_queue(), ^{
                CFRelease(holder); // hold and release in specified queue
            });
        } else {
            // 同步释放缓存
            CFRelease(holder);
        }
    }
}


@end



//@implementation LRUCacheOperation()
//
//@end
