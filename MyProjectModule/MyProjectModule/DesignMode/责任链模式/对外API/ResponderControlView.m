//
//  ResponderAbstractView.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/1.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "ResponderControlView.h"
#import "HTTopControlView.h"
#import "HTBottomControlView.h"
#import "HTMiddleControlView.h"
#import "UIResponder+UIResponderChain.h"
@interface ResponderControlView()
/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (nonatomic, strong) NSDictionary *eventStrategy;
@end
@implementation ResponderControlView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        //  方式1 通 链表的方式 将各个控制层 绑定起来

//      [self setupContentView];
        
    /* 方式 2  通 UIResponder的方式 将各个控制层 绑定起来(有限性 无法全部相应)
       只能从底到上的 父子关系（不能建立平级关系 ）

     */

        [self setupLinkedChainView];
    }
    return self;
}

-(void)setupContentView{
    HTTopControlView *top = [[HTTopControlView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    HTMiddleControlView *mid = [[HTMiddleControlView alloc] initWithFrame:CGRectMake(0, 104, 88, 88)];
    HTBottomControlView *bot = [[HTBottomControlView alloc] initWithFrame:CGRectMake(0, 148, 88, 88)];
    
    top.backgroundColor = [UIColor redColor];
    mid.backgroundColor = [UIColor yellowColor];
    bot.backgroundColor = [UIColor greenColor];
    
    [self addSubview:mid];
    [mid addSubview:top];
    [self addSubview:bot];
    [bot addSubview:top];

    

    
}

#pragma mark --- linkedChain
-(void)setupLinkedChainView{
    
    
    HTTopControlView *top = [[HTTopControlView alloc] initWithFrame:CGRectMake(120, 0, 44, 44)];
    HTMiddleControlView *mid = [[HTMiddleControlView alloc] initWithFrame:CGRectMake(120, 104, 88, 88)];
    HTBottomControlView *bot = [[HTBottomControlView alloc] initWithFrame:CGRectMake(120, 148, 88, 88)];
    
    top.backgroundColor = [UIColor redColor];
    mid.backgroundColor = [UIColor yellowColor];
    bot.backgroundColor = [UIColor greenColor];
    
    [self addSubview:top];
    [self addSubview:mid];
    [self addSubview:bot];
    

//    mid.superior = top;
//    bot.superior = mid;
//    top.superior = bot;

//    控制层 绑定视图
    
    self.nextView(top).nextView(mid).nextView(bot);
    
    [self logAllNextNode];

}

#pragma mark --- Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 1 chainResponder
    [self routerEventWithName:kEventOneName userInfo:@{@"key": [UIColor lightGrayColor]}];

    
    // 2 linked 
    //    [self attachPlayItem:@""];
    [self requestEvent:HTVideoPauseEvent playItem:@""];
    

}



#pragma mark -Chain Event Handle


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,userInfo);
    
    [self handleEventWithName:eventName parameter:userInfo];
    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
    
    
}

// 用 invocation(命令模式) 封装方法 策略 集中处理当前点击视图响应链上的所有事件

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    // 获取invocation对象
    NSInvocation *invocation = self.strategyDictionary[eventName];
    // 设置invocation参数
    [invocation setArgument:&parameter atIndex:2];
    // 调用方法
    [invocation invoke];
}


- (NSDictionary <NSString *, NSInvocation *>*)strategyDictionary {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kEventOneName:[self createInvocationWithSelector:@selector(cellOneEventWithParamter:)],
                           kEventTwoName:[self createInvocationWithSelector:@selector(cellTwoEventWithParamter:)]
                           };
    }
    return _eventStrategy;
}

- (void)cellOneEventWithParamter:(NSDictionary *)paramter {
    
    self.backgroundColor = (UIColor *)paramter[@"key"];
}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"---------参数：%@",paramter);
    
}


@end
