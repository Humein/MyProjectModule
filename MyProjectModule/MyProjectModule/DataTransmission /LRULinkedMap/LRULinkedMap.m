//
//  LRULinkedMap.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/29.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "LRULinkedMap.h"


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
        _tail = node->_prev;
        _tail->_next = nil;
    } else {
        node->_next->_prev = node->_prev;
        node->_prev->_next = node->_next;
    }
    node->_next = _head;
    node->_prev = nil;
    _head->_prev = node;
    _head = node;
}

@end
