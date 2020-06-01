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
#import "UIView+Category.h"
@interface ResponderControlView()
@property (nonatomic, strong) NSDictionary *eventStrategy;
@end
@implementation ResponderControlView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        
    // 1 chainResponder
    [self routerEventWithName:kEventOneName userInfo:@{@"key": @"ResponderControlView"}];return;

    // 2 linked
    ///    [self attachPlayItem:@""]; 作用？
    [self requestEvent:HTVideoPauseEvent playItem:@"啦啦啦啦"];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
    [self setupResponderChainView];
    [self setupLinkedChainView];
    }
    return self;
}

#pragma mark - UIResponderChain 绑定
-(void)setupResponderChainView{
    HTTopControlView *top = [[HTTopControlView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    HTMiddleControlView *mid = [[HTMiddleControlView alloc] initWithFrame:CGRectMake(0, 104, 88, 88)];
    HTBottomControlView *bot = [[HTBottomControlView alloc] initWithFrame:CGRectMake(0, 148, 88, 88)];
    
    top.backgroundColor = [UIColor redColor];
    mid.backgroundColor = [UIColor yellowColor];
    bot.backgroundColor = [UIColor greenColor];
    /**
     通过 UIResponder的方式 将各个节点绑定起来
     只能通过父子关系绑定（不能建立平级关系). 而且父的事件不能引发子的相应。
     */
    [self addSubview:mid];
    [mid addSubview:top];
    [self addSubview:bot];
    [bot addSubview:top];
}

#pragma mark - LinkResponder 绑定
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
    
    /**
     通链表的方式将各个控制层绑定起来.链表上各个节点都会响应。
     它的
     - 事件传递顺序
       不管从链表中哪个节点发送事件，它都要先找到链表头部节点<做成双向链表，也是方便查找头部节点>
      然后从头节点开始相应事件 (self->top->mid->bot)
     - 事件响应顺序
       先说结果 (bot->mid->top->self). 大家会疑惑这怎么和链表的顺序相反呢，因为 这是递归呀。。。。
     调用栈。 方法顺序压栈。执行时候最后一个出来。 这个和 swift的 有出入
     
     总结 其实可以把这个看作 我们手动实现了UIResponder。 然后它的事件传递和事件响应 一样的
     */
    self.nextView(top).nextView(mid).nextView(bot);
    [self logAllNextNode];

}


#pragma mark - LinkResponder
- (void)attachPlayItem:(id )playItem
{
//    [super attachPlayItem:playItem];
}

- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    self.nextNodeView ? [self.nextNodeView responseEvent:eventType playItem:playItem] : nil;
    NSLog(@"%@>>>>>>>相应的事件%ld>>>>>传递的数据%@",[self class],(long)eventType,playItem);
}

#pragma mark - UIResponderChain
// 重写UIResponderChain 方法 并 把响应链继续传递下去
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
        
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
//    NSLog(@"---------参数：%@",paramter);
}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"---------参数：%@",paramter);
    
}


@end
