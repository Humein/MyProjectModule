//
//  MultiDelegate.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/9/2.
//  Copyright © 2020 xinxin. All rights reserved.
//

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
