//
//  AppDelegate+DownManagerHelper.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "AppDelegate+DownManagerHelper.h"
#import <objc/message.h>

#define CompletionHandlerName       "completionHandler"

@implementation AppDelegate (DownManagerHelper)

- (void (^)())completionHandler
{
    return objc_getAssociatedObject(self, CompletionHandlerName);
}
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    NSLog(@"%s", __FUNCTION__);
    objc_setAssociatedObject(self, CompletionHandlerName, completionHandler, OBJC_ASSOCIATION_COPY);
}


@end
