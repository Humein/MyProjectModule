//
//  LOTAnimationLRUCache.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/24.
//  Copyright © 2020 xinxin. All rights reserved.
//

/**
 LRU 概念以及实现思路
 - LRU算法的原理比较简单，数据存储的数据结构为链表。当访问数据时，如缓存中有数据，则将该数据移动至链表的顶端；没有该数据则在顶端加入该数据，并移除链表中的低端的数据
 */

#import "LOTAnimationLRUCache.h"

//首先这是定义一个最大的缓存数量
static const NSInteger kLOTCacheSize = 50;

//类实现中主要维护两张表，字典通过key-value pair存储动画,用数组存储key
@implementation LOTAnimationLRUCache {
  NSMutableDictionary *animationsCache_;// 储存动画
  NSMutableArray *lruOrderArray_; //保存key
}
//单例的实现，会iOS 的都会写
+ (instancetype)sharedCache {
  static LOTAnimationLRUCache *sharedCache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedCache = [[self alloc] init];
  });
  return sharedCache;
}
//本类初始化的时候，初始化数组和字典
- (instancetype)init {
  self = [super init];
  if (self) {
    animationsCache_ = [[NSMutableDictionary alloc] init];
    lruOrderArray_ = [[NSMutableArray alloc] init];
  }
  return self;
}
//这是最主要的方法
- (void)addAnimation:(LOTComposition *)animation forKey:(NSString *)key{
//清除超过最大缓存量的值
 if (lruOrderArray_.count >= kLOTCacheSize) {
        //数组第一个key就是最早存入数组
        NSString *oldKey = lruOrderArray_.firstObject;
       //移除旧key
        [lruOrderArray_ removeObject:oldKey];
       //移除值
        [animationsCache_ removeObjectForKey:oldKey];
    }
    //移除旧key
    [lruOrderArray_ removeObject:key];
    //添加新key
    [lruOrderArray_ addObject:key];
    //存储值
    [animationsCache_ setObject:animation forKey:key];
}
//通过key 获取 value
- (LOTComposition *)animationForKey:(NSString *)key {
  if (!key) {
    return nil;
  }
//从 字典中获取 value
  LOTComposition *animation = [animationsCache_ objectForKey:key];
//更新数组key
  [lruOrderArray_ removeObject:key];
  [lruOrderArray_ addObject:key];
  return animation;
}
//清除缓存 ，一般在收到内存警告的时候执行此操作，也是一个缓存类必须提供的接口
- (void)clearCache {
  [animationsCache_ removeAllObjects];
  [lruOrderArray_ removeAllObjects];
}
// 移除对应key 的缓存
- (void)removeAnimationForKey:(NSString *)key {
  [lruOrderArray_ removeObject:key];
  [animationsCache_ removeObjectForKey:key];
}
// 销毁整个缓存
- (void)disableCaching {
  [self clearCache];
  animationsCache_ = nil;
  lruOrderArray_ = nil;
}

@end
