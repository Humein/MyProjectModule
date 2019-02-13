//
//  ResponderAbstractView.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/1.
//  Copyright © 2018 xinxin. All rights reserved.
//

/*
  思路：
 先用（响应链模式）将各个对象绑定在一起，然后在routerEvent: 中处理事件，如果事件来源有多个采用strategy(策略模式）来代替if-else语句，其中策略模式是通过 invocation(命令模式) (NSDictionary <NSString *, NSInvocation *>*)strategyDictionary 封装方法策略。在事件层层向上传递的时候，每一层都可以往UserInfo这个dictionary中添加数据。那么到了最终事件处理的时候，就能收集到各层综合得到的数据，从而完成最终的事件处理（装饰者模式）
 */

#import "ResponderControlView.h"
#import "HTTopControlView.h"
#import "HTBottomControlView.h"
#import "HTMiddleControlView.h"
#import "UIResponder+UIResponderChain.h"

NSString * const kDistributeEvent = @"1";
NSString * const kEventOneName = @"2";
NSString * const kEventTwoName = @"3";


@interface ResponderControlView(){
    HTTopControlView *_top;
}
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
    
    
    _top = [[HTTopControlView alloc] initWithFrame:CGRectMake(120, 0, 44, 44)];
    HTMiddleControlView *mid = [[HTMiddleControlView alloc] initWithFrame:CGRectMake(120, 104, 88, 88)];
    HTBottomControlView *bot = [[HTBottomControlView alloc] initWithFrame:CGRectMake(120, 148, 88, 88)];
    
    _top.backgroundColor = [UIColor redColor];
    mid.backgroundColor = [UIColor yellowColor];
    bot.backgroundColor = [UIColor greenColor];
    
    [self addSubview:_top];
    [self addSubview:mid];
    [self addSubview:bot];
    

//    mid.superior = top;
//    bot.superior = mid;
//    top.superior = bot;
    
    
#pragma mark -自定义双向响应链表 入口
//    控制层 绑定视图
    self.nextView(_top).nextView(mid).nextView(bot);
    
    [self logAllNextNode];



    
}

#pragma mark --- Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
#pragma mark -借用 responder chain 入口
    [self routerEventWithName:kDistributeEvent userInfo:@{@"key": [UIColor lightGrayColor]}];

    
    //    [self attachPlayItem:@""];
    //    自定义双向响应链表
    [self requestEvent:HTVideoPauseEvent playItem:@""];
    

}



#pragma mark -Chain Event Handle


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"%@->eventName ===== %@,userInfo =====%@",[self class],eventName,userInfo);

    //    如果事件来源有多个，那就无法避免需要if-else语句来针对具体事件作相应的处理。这种情况下，会导致if-else语句极多。所以，可以考虑采用strategy(策略)模式来消除if-else语句。
    
//    if (eventName == 0) {
//        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
//    }else if (eventName == 100){
//        NSLog(@"联动事件");
//    }
//    else{
//        NSLog(@"无法响应");
//    }
    
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

//用strategy的话，就可以把事件分发到不同的对象中去了，

- (NSDictionary <NSString *, NSInvocation *>*)strategyDictionary {
    if (!_eventStrategy) {
        _eventStrategy = @{
//                           第34行，把[self createInvocationWithSelector]中的self换成其他对象，那就扔过去了。
//                            self也是一个对象，你的写法相当于是把self作为“不同的对象”去对待
                           kDistributeEvent:[_top createInvocationWithSelector:@selector(cellDistributeEventWithParamter:)],
                           kEventOneName:[self createInvocationWithSelector:@selector(cellOneEventWithParamter:)],
                           kEventTwoName:[self createInvocationWithSelector:@selector(cellTwoEventWithParamter:)],
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
