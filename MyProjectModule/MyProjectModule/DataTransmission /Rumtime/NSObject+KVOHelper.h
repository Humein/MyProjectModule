//
//  NSObject+KVOHelper.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PXYKVOCompleteBlock)(id observer, NSString *keyPath, id oldValue, id newValue);

@interface NSObject (KVOHelper)
/**
 添加 KVO Block
 */
- (void)pxy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath completeBlock:(PXYKVOCompleteBlock)completeBlock;

/**
 移除 KVO Block
 */
- (void)pxy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
