//
//  CallbackAndCompletionHandlerForBlock.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CallbackAndCompletionHandlerForBlock.h"

/**
 Lib 通知开发者，Lib操作已经完成。一般命名为 Callback
 开发者通知 Lib，开发者的操作已经完成。一般可以命名为 CompletionHandler。
 
 CompletionHandler + Delegate
 1:  - (void)userNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
 withCompletionHandler:(void (^)(void))completionHandler;
 
 
 2:  - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler;
 
 3: - (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler;
 
 The block to execute when you have finished processing the user’s response. You must execute this block from your method and should call it as quickly as possible. The block has no return value or parameters.
 
CompletionHandler + Block
 
 1: this demo
 
 */
@implementation CallbackAndCompletionHandlerForBlock

-(void)setFetchProfilesBlock:(LCCKFetchProfilesBlock)fetchProfilesBlock{
    
    NSLog(@"doSomeThing");
}



@end
