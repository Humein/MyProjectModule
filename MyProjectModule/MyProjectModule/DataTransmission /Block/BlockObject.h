//
//  BlockObject.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

//(returnType(^blockName)(parameter))block

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BlockObject : UIViewController

#pragma mark ---  1 无返回值 有参数 非匿名(属性) block
typedef void(^ClickButtonBlock)(NSUInteger buttonType, UIButton * clickButton);
typedef void (^PopBlock)(void);

@property (nonatomic,copy)  void (^rightBarItemClickBlock)(UIButton *button, NSInteger index);
@property (nonatomic,copy) PopBlock popBlock;


typedef void (^Block1)(void);
typedef void (^Block2)(NSDictionary *dic);
typedef NSString *(^Block3)(NSDictionary *dic);
typedef BlockObject *(^Block4)(NSDictionary *dic, NSString *str);
-(void)findDocSuccess:(Block2)block2 withFailure:(Block3)block3;
-(BlockObject * (^)(NSString *kindOfFood))findDoc1Success:(Block2)block2 withFailure:(Block3)block3;
@property (nonatomic,copy) Block4 block4;

#pragma mark --- 2 无返回值 有参数 匿名(参数)  block （1-异步回调  2- 无需实例对象 配置对象的参数）

typedef void(^Success)(id data);
typedef void(^Failure)(NSString *errorMessage);
/// 异步回调

- (void)requestNoticeDataWithParameter:(NSDictionary *)dic isWaiting:(BOOL)isWaiting success:(Success)success failure:(Failure)failure;
-(void)activeEventBlock:(void(^)(BOOL state))block;


/// 我先抛出后更新
typedef void (^EventBlock)(id titleTyple);
typedef void(^SessionHeaderEvent)(id eventType,UIButton *sender, EventBlock event);
@property (nonatomic, copy) SessionHeaderEvent buttonCallback;



typedef void (^MiniProgramResultBlock)(int miniProgramResult);
typedef void (^IDBlock)(id configModel);
/// block对象做为入参数 - 可以对象话/规范化入参
- (void)jumpConfig:(IDBlock)configBlock completeBlock:(MiniProgramResultBlock)completeBlock;
//这个也是  +(void)requestConfig:(RequestMediatorBaseBusniessBlock)configBlock withSuccess:(Succsess)succsess andFailure:(Failure)failure


#pragma mark --- 3 有返回值 有参数 匿名 block
//创建NavigationBarItem    block作为返回值,链式编程
- (BlockObject * (^) (NSString * rightName,CGRect frame,BOOL isImage))rightBarItem;



//常见的写法
- (void)run1;
- (void)eat1;


//链式编程调用
- (BlockObject *)run2;
- (BlockObject *)eat2;



//函数式编程
// -- 函数式编程步骤1 -> 调用方法使用小括号

- (void (^)(void))run3;
- (void (^)(void))eat3;

// -- 函数式编程步骤2 --> 链式调用多个方法
- (BlockObject * (^)(void))run4;
- (BlockObject * (^)(void))eat4;

// -- 函数式编程步骤3 --> 传递参数
//函数式编程和链式编程    使用链式调用的方式，明显更能使代码更简洁，更连贯。
//而实现这一方式的本质是返回一个返回值为自身的Block对象。
- (BlockObject * (^)(double distance))run5;
- (BlockObject * (^)(NSString *kindOfFood))eat5;




- (void)testMethod;

@end
