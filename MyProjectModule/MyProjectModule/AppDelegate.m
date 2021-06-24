//
//  AppDelegate.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AspectTrackMananer.h"
#import "AppDelegate+DownManagerHelper.h"
#import "MainTabBarViewController.h"
#import "MatrixHandleManager.h"
#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#endif
@interface AppDelegate (){
    FBMemoryProfiler *_memoryProfiler;
}

@end

@implementation AppDelegate
{
//    FlutterPluginAppLifeCycleDelegate *_lifeCycleDelegate;
}

- (instancetype)init {
    if (self = [super init]) {
//        _lifeCycleDelegate = [[FlutterPluginAppLifeCycleDelegate alloc] init];
    }
    return self;
}




//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//    [self.window setFrame:bounds];
//    [self.window setBounds:bounds];
//    
//    return YES;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 腾讯 APM
    [MatrixHandleManager new];
    // 滴滴 APM
    #ifdef DEBUG
    [[DoraemonManager shareInstance] installWithPid:@"878bed371b549042e418441819df6f3f"];//productId为在“平台端操作指南”中申请的产品id
    #endif
    #if DEBUG
    FBMemoryProfiler *memoryProfiler = [FBMemoryProfiler new];
    [memoryProfiler enable];
    _memoryProfiler = memoryProfiler;
    #endif
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = [[MainTabBarViewController alloc] init];
    [window makeKeyAndVisible];
    self.window = window;
    
    

    self.appName = @"";
//    _name = @"";    测试 分类 的 成员变量
//    self.bppName = @"";

    [AspectTrackMananer trackAspectHooks];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAllButUpsideDown;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*   web 跳转到指定页面
 iOS 9 通用链接（Universal Links）  https://www.jianshu.com/p/c2ca5b5f391f
 web 调起 App？ 光知道 scheme 可不够！ https://juejin.im/post/5ac44a9c6fb9a028d82bf98b
 js在微信、微博、QQ、Safari唤起App的解决方案 https://segmentfault.com/a/1190000012940046
 
 
 怎么把网页的信息通过通用链接传过来呢，比如正在浏览的商品信息等？
 
 需要实现： - (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler方法，在里面捕获网页链接，然后做一个本地映射，或者取出你想要的参数，再做本地跳转就可以了
 */

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler{

    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webUrl = userActivity.webpageURL;
        if ([webUrl.host isEqualToString:@"hatu.com"]) {
            // 打开对应页面
        }else{
            // 谓识别 直接打开
            [[UIApplication sharedApplication] openURL:webUrl];
        }
    }
    
    return YES;
}
@end
