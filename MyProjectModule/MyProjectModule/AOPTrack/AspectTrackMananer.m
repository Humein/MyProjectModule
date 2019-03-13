//
//  AspectTrackMananer.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/3/13.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "AspectTrackMananer.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation AspectTrackMananer

+(void)trackAspectHooks{
    
    [AspectTrackMananer trackViewAppear];
    [AspectTrackMananer trackBttonEvent];

    
}

#pragma mark -- 监控统计用户进入此界面的时长，频率等信息
+ (void)trackViewAppear{
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   
                                   //用户统计代码写在此处
                                   NSLog(@"[打点统计]:%@ viewWillAppear",NSStringFromClass([info.instance class]));

                                   
                               }
                                    error:NULL];
    
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   
                                   //用户统计代码写在此处
                                   NSLog(@"[打点统计]:%@ viewWillDisappear",NSStringFromClass([info.instance class]));

                               }
                                    error:NULL];
    
    //other hooks ... goes here
    //...
}


+ (void)trackBttonEvent{
    
    __weak typeof(self) ws = self;
    //设置事件统计
    //放到异步线程去执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //读取plist配置文件，获取需要统计的事件列表
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EventList" ofType:@"plist"];
        NSDictionary *eventStatisticsDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        for (NSString *classNameString in eventStatisticsDict.allKeys) {
            //使用运行时创建类对象
            const char * className = [classNameString UTF8String];
            //从一个字串返回一个类
            Class newClass = objc_getClass(className);
            
            NSArray *pageEventList = [eventStatisticsDict objectForKey:classNameString];
            for (NSDictionary *eventDict in pageEventList) {
                //事件方法名称
                NSString *eventMethodName = eventDict[@"MethodName"];
                SEL seletor = NSSelectorFromString(eventMethodName);
                NSString *eventId = eventDict[@"EventId"];
                
                [ws trackEventWithClass:newClass selector:seletor eventID:eventId];
                [ws trackTableViewEventWithClass:newClass selector:seletor eventID:eventId];
                [ws trackParameterEventWithClass:newClass selector:seletor eventID:eventId];
                
                
                
            }
        }
    });
}

#pragma mark -- 1.监控button和tap点击事件(不带参数)
+ (void)trackEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        if ([eventID isEqualToString:@"xxx"]) {
            //            [EJServiceUserInfo isLogin]?[MobClick event:eventID]:[MobClick event:@"???"];
        }else{
            //            [MobClick event:eventID];
        }
    } error:NULL];
}


#pragma mark -- 2.监控button和tap点击事件（带参数）
+ (void)trackParameterEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,UIButton *button) {
        
        NSLog(@"button---->%@",button);
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        
    } error:NULL];
}


#pragma mark -- 3.监控tableView的点击事件
+ (void)trackTableViewEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSSet *touches, UIEvent *event) {
        
        NSString *className = NSStringFromClass([aspectInfo.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        NSLog(@"section---->%@",[event valueForKeyPath:@"section"]);
        NSLog(@"row---->%@",[event valueForKeyPath:@"row"]);
        NSInteger section = [[event valueForKeyPath:@"section"]integerValue];
        NSInteger row = [[event valueForKeyPath:@"row"]integerValue];
        
        //统计事件
        if (section == 0 && row == 1) {
            //            [MobClick event:eventID];
        }
        
    } error:NULL];
}


@end
