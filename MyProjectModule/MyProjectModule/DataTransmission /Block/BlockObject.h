//
//  BlockObject.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BlockObject : UIViewController
//@property (nonatomic, copy) void(^popBlock)(void);

//<1>As a property 逆向传值
@property (nonatomic,copy) void (^rightBarItemClickBlock)(UIButton *button, NSInteger index);

//创建NavigationBarItem    block作为返回值,链式编程
- (BlockObject * (^) (NSString * rightName,CGRect frame,BOOL isImage))rightBarItem;

//<2> block 作为参数
   // one : 网络请求
/**
 *  成功。
 *  @param data 返回的数据。
 */
typedef void(^Success)(id data);
/**
 *  失败。
 *  @param errorMessage 失败原因。
 */
typedef void(^Failure)(NSString *errorMessage);

- (void)requestNoticeDataWithParameter:(NSDictionary *)dic isWaiting:(BOOL)isWaiting success:(Success)success failure:(Failure)failure;

   //参数模型

typedef void (^MiniProgramResultBlock)(int miniProgramResult);

typedef void (^modelBlock)(id configModel);

//- (void)jumpConfig:(void(^)(id configModel))configBlock
//     completeBlock:(MiniProgramResultBlock)completeBlock;

- (void)jumpConfig:(modelBlock)configBlock completeBlock:(MiniProgramResultBlock)completeBlock;

@end
