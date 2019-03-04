//
//  LRULinkedMap.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/29.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A node in linked map.
 Typically, you should not use this class directly.
 实现linkedNode
 
 1: __unsafe_unretained
 区别是：
 __weak修饰的对象被释放后，指向对象的指针会置空，也就是指向nil,不会产生野指针；
 而__unsafe_unretained修饰的对象被释放后，指针不会置空，而是变成一个野指针，那么此时如果访问这个对象的话，程序就会Crash，抛出BAD_ACCESS的异常
 
 __weak 对性能会有一定的消耗，使用__weak,需要检查对象是否被释放，在追踪是否被释放的时候当然需要追踪一些信息，那么此时__unsafe_unretained比__weak快，而且一个对象有大量的__weak引用对象的时候，当对象被废弃，那么此时就要遍历weak表，把表里所有的指针置空，消耗cpu资源。
 
 当你明确对象的生命周期的时候，可以使用__unsafe_unretained替代__weak,可以稍微提高一些性能，虽然这点性能微乎其微
 举个例子，当A拥有B对象，A消亡B也消亡，这样当B存在，A也一定会存在的时候，此时B要调用A的接口，就可以通过__unsafe_unretained 保持对A的引用关系
 
 2:@package
 (1）@public (公开的)包含@protected的作用范围；并且在有对象的前提下，任何地方都可以直接访问。
 
 （2）@protected （受保护的）只能在当前类和子类的对象方法中访问（在@interface  @end之间声明的成员变量如果不做特别的说明，那么其默认是protected的）
 
 （3）@private （私有的）只能在当前类的对象方法中才能直接访问（定义在m文件中的类扩展部分或者是@implementation内）
 
 （4）@package (框架级别的)作用域介于私有和公开之间，只要处于同一个框架中就可以直接通过变量名访问
 */
@interface LinkedMapNode : NSObject {
    @package
    __unsafe_unretained LinkedMapNode *_prev; // retained by dic
    __unsafe_unretained LinkedMapNode *_next; // retained by dic
    id _key;
    id _value;
    // 当前缓存内存开销
    NSUInteger _cost;
    // 缓存时间
    NSTimeInterval _time;
}
@end

/**
 A linked map used by YYMemoryCache.
 It's not thread-safe and does not validate the parameters.
 
 Typically, you should not use this class directly.
 */
@interface LRULinkedMap : NSObject{
    @package
    // 用字典保存所有节点_YYLinkedMapNode (为什么不用oc字典?因为用CFMutableDictionaryRef效率高，毕竟基于c)
    CFMutableDictionaryRef _dic; // do not set object directly
    // 总缓存开销
    NSUInteger _totalCost;
    // 总缓存数量
    NSUInteger _totalCount;
    LinkedMapNode *_head; // MRU, do not change it directly
    LinkedMapNode *_tail; // LRU, do not change it directly
    // 是否在主线程上，异步释放 _YYLinkedMapNode对象
    BOOL _releaseOnMainThread;
    // 是否异步释放 _YYLinkedMapNode对象
    BOOL _releaseAsynchronously;
}

/// Insert a node at head and update the total cost.
/// Node and node.key should not be nil.
// 添加节点到链表头节点
- (void)insertNodeAtHead:(LinkedMapNode *)node;

/// Bring a inner node to header.
/// Node should already inside the dic.
// 移动当前节点到链表头节点
- (void)bringNodeToHead:(LinkedMapNode *)node;

/// Remove a inner node and update the total cost.
/// Node should already inside the dic.
// 移除链表节点
- (void)removeNode:(LinkedMapNode *)node;

/// Remove tail node if exist.
// 移除链表尾节点(如果存在)
- (LinkedMapNode *)removeTailNode;

/// Remove all node in background queue.
- (void)removeAll;

@end



@interface LRUCacheOperation : NSObject

//get

//put

@end


@interface SimulaCache : NSObject

@end
