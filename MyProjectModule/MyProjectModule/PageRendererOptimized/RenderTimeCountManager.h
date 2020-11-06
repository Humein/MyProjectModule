//
//  RenderTimeCountManager.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/5.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RenderTimeCountManager : NSObject
+ (instancetype)sharedInstance;
-(NSString *)getTimeStamp;
@end

NS_ASSUME_NONNULL_END
