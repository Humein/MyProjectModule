//
//  CallbackAndCompletionHandlerForBlock.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//


// 信息 对换

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

/*!
 *  @brief The block to execute with the users' information for the userIds. Always execute this block at some point when fetching profiles completes on main thread. Specify users' information how you want ChatKit to show.
 *  @attention If you fetch users fails, you should reture nil, meanwhile, give the error reason.
 */
typedef void(^LCCKFetchProfilesCompletionHandler)(NSArray<id<UIApplicationDelegate>> *users, NSError *error);

/*!
 *  @brief When LeanCloudChatKit wants to fetch profiles, this block will be invoked.
 *  @param userIds User ids
 *  @param completionHandler The block to execute with the users' information for the userIds. Always execute this block at some point during your implementation of this method on main thread. Specify users' information how you want ChatKit to show.
 */
typedef void(^LCCKFetchProfilesBlock)(NSArray<NSString *> *userIds, LCCKFetchProfilesCompletionHandler completionHandler);


@interface CallbackAndCompletionHandlerForBlock : NSObject

@property (nonatomic, copy) LCCKFetchProfilesBlock fetchProfilesBlock;

/*!
 *  @brief Add the ablitity to fetch profiles.
 *  @attention  You must get peer information by peer id with a synchronous implementation.
 *              If implemeted, this block will be invoked automatically by LeanCloudChatKit for fetching peer profile.
 */
- (void)setFetchProfilesBlock:(LCCKFetchProfilesBlock)fetchProfilesBlock;


@end
