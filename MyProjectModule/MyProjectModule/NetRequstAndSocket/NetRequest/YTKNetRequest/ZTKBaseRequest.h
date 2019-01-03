//
//  ZTKBaseRequest.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/3.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RequestCompleteFilterBlock)(void);

typedef void(^RequestFailedFilterBlock)(void);

typedef void(^CacheFileNameFilterForRequestArgumentBlock)(id argument);


@interface ZTKBaseRequest : YTKRequest




@end

NS_ASSUME_NONNULL_END
