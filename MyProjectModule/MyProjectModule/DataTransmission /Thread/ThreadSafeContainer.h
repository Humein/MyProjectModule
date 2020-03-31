//
//  ThreadSafeContainer.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/3/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTKNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreadSafeContainer : UIViewController
/// 设计一个只读的容器
@property (nonatomic,readonly,strong) NSArray<id<YTKUrlFilterProtocol>> *readOnlyArray;

/// 设计一个读写安全的容器

@property (nonatomic,copy) NSString *someString;


@end

NS_ASSUME_NONNULL_END
