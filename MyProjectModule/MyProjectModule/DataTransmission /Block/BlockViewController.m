//
//  BlockViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "BlockViewController.h"
#import "CallbackAndCompletionHandlerForBlock.h"
@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self navigationBar];
    
    [self CallbackAndCompletionHandlerForBlock];
    
    
}

//导航
-(void)navigationBar{
    //    设置导航
    
    self.rightBarItem(@"搜索", CGRectMake(0, 0, 30, 30), YES).rightBarItem(@"回收站",CGRectMake(0, 0, 30, 30),YES).rightBarItem(@"日历", CGRectMake(0, 0, 30, 30), NO);
    
    //    导航事件
    self.rightBarItemClickBlock = ^(UIButton *button, NSInteger index) {
        
    };
    
}


// app <-> server
-(void)CallbackAndCompletionHandlerForBlock{
    
    CallbackAndCompletionHandlerForBlock *CCBlock = [CallbackAndCompletionHandlerForBlock new];
    
    [CCBlock setFetchProfilesBlock:^(NSArray<NSString *> *userIds, LCCKFetchProfilesCompletionHandler completionHandler) {
        
        if (userIds.count == 0) {
            NSInteger code = 0;
            NSString *errorReasonText = @"User ids is nil";
            NSDictionary *errorInfo = @{
                                        @"code":@(code),
                                        NSLocalizedDescriptionKey : errorReasonText,
                                        };
            NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                                 code:code
                                             userInfo:errorInfo];
            
            !completionHandler ?: completionHandler(nil, error);
            return;
        }
        
        NSMutableArray *users = [NSMutableArray arrayWithCapacity:userIds.count];
#warning 注意：以下方法循环模拟了通过 userIds 同步查询 users 信息的过程，这里需要替换为 App 的 API 同步查询
        
        [userIds enumerateObjectsUsingBlock:^(NSString *_Nonnull clientId, NSUInteger idx,
                                              BOOL *_Nonnull stop) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"peerId like %@", clientId];
            //这里的LCCKContactProfiles，LCCKProfileKeyPeerId都为事先的宏定义，
            NSArray *searchedUsers = [NSArray array];
            if (searchedUsers.count > 0) {
                NSDictionary *user = searchedUsers[0];
                NSURL *avatarURL = [NSURL URLWithString:user[@""]];
                id user_ = @"";
                [users addObject:user_];
            } else {
                //注意：如果网络请求失败，请至少提供 ClientId！
                id user_ = @"";
                [users addObject:user_];
            }
        }];
        // 模拟网络延时，3秒
        //         sleep(3);
        
#warning 重要：completionHandler 这个 Bock 必须执行，需要在你**获取到用户信息结束**后，将信息传给该Block！

    }];
    
}


@end