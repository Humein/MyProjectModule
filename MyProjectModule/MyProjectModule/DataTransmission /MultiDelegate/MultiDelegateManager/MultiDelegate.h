//
//  MultiDelegate.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/9/2.
//  Copyright © 2020 xinxin. All rights reserved.
//
/**
 MultiDelegate是Objective-C的一个多路委托类。换句话说，它将委派方法分派到多个对象，而不是被限制到单个委派对象。您还可以将其用作一种通用的方法分派机制。欲了解更多信息，请参阅博文。

 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiDelegate : NSObject

@property (readonly, nonatomic) NSPointerArray* delegates;
@property (nonatomic, assign) BOOL silentWhenEmpty;

- (id)initWithDelegates:(NSArray*)delegates;
- (void)addDelegate:(id)delegate;
- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate;
- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate;
- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END
