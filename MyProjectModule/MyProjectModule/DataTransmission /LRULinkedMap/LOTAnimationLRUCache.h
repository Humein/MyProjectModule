//
//  LOTAnimationLRUCache.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/24.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class LOTComposition;

@interface LOTAnimationLRUCache : NSObject

/// Global Cache 单例类
+ (instancetype)sharedCache;

/// Adds animation to the cache  主要添加对象API
- (void)addAnimation:(LOTComposition *)animation forKey:(NSString *)key;

/// Returns animation from cache.  获取缓存
- (LOTComposition * _Nullable)animationForKey:(NSString *)key;

/// Removes a specific animation from the cache 移除缓存
- (void)removeAnimationForKey:(NSString *)key;

/// Clears Everything from the Cache 清除缓存
- (void)clearCache;

/// Disables Caching Animation Model Objects 销毁缓存模型
- (void)disableCaching;

@end

NS_ASSUME_NONNULL_END
