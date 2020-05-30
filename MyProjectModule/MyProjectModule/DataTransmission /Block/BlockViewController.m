//
//  BlockViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "BlockViewController.h"
#import "CallbackAndCompletionHandlerForBlock.h"
#import "SimulationChainFucCode.h"
@interface BlockViewController (){
    NSString *_strBlock;
}

@end

@implementation BlockViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self findDocSuccess:^(NSDictionary *dic) {
        
    } withFailure:^NSString *(NSDictionary *dic) {
        return @"111111";
    }];

    
    [self findDoc1Success:^(NSDictionary *dic) {
        
    } withFailure:^NSString *(NSDictionary *dic) {
        return @"222222";
    }];
    
    self.block4 = ^BlockObject *(NSDictionary *dic, NSString *str) {
        BlockObject *testStr = [BlockObject new];
        return testStr;
    };

}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self navigationBar];
    
    [self CallbackAndCompletionHandlerForBlock];
    
    
    [self fucntionCode];
    
    [self chanedCode];
    
    [self simulation];
}

//导航
-(void)navigationBar{
    //    设置导航
    
    self.rightBarItem(@"搜索", CGRectMake(0, 0, 30, 30), YES).rightBarItem(@"回收站",CGRectMake(0, 0, 30, 30),YES).rightBarItem(@"日历", CGRectMake(0, 0, 30, 30), NO);
    
    //    导航事件
    int a = 0;
    __weak typeof(self) weakSelf=self;
    // block 中处理 成员变量循环引用
    self.rightBarItemClickBlock = ^(UIButton *button, NSInteger index) {
        BlockViewController *strongSelf = weakSelf;
        strongSelf->_strBlock = @"";
//        int a = 1;
        NSLog(@"%@", @(a));
    };
    /**
     @weakify(self)
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         @strongify(self)
         self->pageNum = @"1";
     }];
     */
    
    int b = 1;
//    int b = 0;
    
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


//实现链式编程
-(void)chanedCode{

    BlockObject *bj = [[BlockObject alloc] init];
    
    [[[[bj run2] eat2] eat2] run2];
    
//    BlockObject *bjN = bj.run2.eat2;
    
    
    
}


//实现函数式编程
-(void)fucntionCode{
    
    // 第一步  使用小括号
    BlockObject *bj = [[BlockObject alloc] init];
    bj.run3();
    bj.eat3();
    
    // 第二步  实现多个方法调用
    BlockObject *bj1 = [[BlockObject alloc] init];
    bj1.eat4().eat4().run4().eat4();
    self.eat4().run4();
    
    
    // 第三步 传递参数
    
    BlockObject *bjOvew = [[BlockObject alloc] init];
    bjOvew.eat5(@"面包").run5(18.5).eat5(@"牛奶").run5(28.5);
    
    
}

// 模拟 masonry
-(void)simulation{
    
    [self.view addSubview:[SimulationChainFucCode initWith:^(SimulationChainFucCode *View) {
        
        View.viewFrame(CGRectMake(100, 200, 20, 20)).layerCornerRadious(2).ColorString(@"颜色自己设置");
        
    }]];
    
    
}

@end
