//
//  NSInvocationForStrategyViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/10/9.
//  Copyright © 2018 xinxin. All rights reserved.
//

// NSInvocation 实现


#import "NSInvocationForStrategyViewController.h"

static NSString *const oneEvent = @"one";
static NSString *const twoEvent = @"two";
static NSString *const threeEvent = @"three";


@interface NSInvocationForStrategyViewController ()


@property (nonatomic,strong) NSDictionary *eventStrategy;


@end

@implementation NSInvocationForStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*
 NSInvocation的使用步骤
 (1).指定一个 SEL
 (2).根据这个 SEL 创建 NSMethodSignature
 (3).根据这个 NSInvocation 创建一个NSInvocation对象
 (4).设置这个 invocation 的 target、selector、参数 、返回值
 (5).调用NSInvocation对象的invoke方法
 
 
 */
    
    [self invocationTestOne];
    [self invocationTestTwo];
    
 
    
}


//1
-(void)invocationTestOne{
    
    
    
    NSString *string0 = @"Hello";
    NSString *addString0 = [string0 stringByAppendingString:@" World!"];
    
// 用NSInvocation转换后：
    
    
    NSString *string = @"Hello";
    void* addString;
    NSString* stringToAppend = @" World!";
    
    //invocationWithMethodSignature: 使用给定方法签名来构建消息的对象。
    NSMethodSignature *signature = [string methodSignatureForSelector:@selector(stringByAppendingString:)];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置target
    invocation.target = string;
    invocation.selector = @selector(stringByAppendingString:);
    
    
    //设置参数即上面对应的World！字符串，index为2 是因为0、1两个参数已经被target和selector占用
    [invocation setArgument:&stringToAppend atIndex:2];
    //执行制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
    
    
    //得到返回值 并赋值addString
    if (signature.methodReturnLength > 0) {
        [invocation getReturnValue:&addString];
        NSString *str = (__bridge NSString *)addString;
        NSLog(@"%@",str);
    }
    
    
    
}

//2
-(void)invocationTestTwo{
    
    NSString *methodNameStr = @"test:withArg2:";
    SEL selector = NSSelectorFromString(methodNameStr);
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    //此时我们应该判断方法是否存在，如果不存在这抛出异常
    if (signature == nil) {
        //aSelector为传进来的方法
        NSString *info = [NSString stringWithFormat:@"%@方法找不到", NSStringFromSelector(selector)];
        [NSException raise:@"方法调用出现异常" format:info, nil];
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    NSString *arg1 = @"arg1";
    NSString *arg2 = @"arg2";
    [invocation setArgument:&arg1 atIndex:2];
    [invocation setArgument:&arg2 atIndex:3];
    
    /*
     // invocation 有2个隐藏参数，所以 argument 从2开始
     if ([arguments isKindOfClass:[NSArray class]]) {
     NSInteger count = MIN(arguments.count, signature.numberOfArguments - 2);
     for (int i = 0; i < count; i++) {
     const char *type = [signature getArgumentTypeAtIndex:2 + i];
     // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
     if (strcmp(type, "@") == 0) {
     id argument = arguments[i];
     [invocation setArgument:&argument atIndex:2 + i];
     }
     }
     }
     */
    
    
    [invocation invoke];
    
    if (signature.methodReturnLength>0) {
        id returnResult = nil;
        [invocation getReturnValue:&returnResult];
        NSLog(@"%@",returnResult);
    }

}

- (NSString *)test:(NSString *)ceshiStr withArg2:(NSString *)arg2
{
    NSLog(@"%@----%@",ceshiStr,arg2); // log: arg1----arg2
    return @"返回值";
}


//3  页面强制旋转中用到的 NSInvocation

-(void)invocationTree{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}



// 4 结合strategy

#pragma mark - event response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    
    NSInvocation *invocation = self.eventStrategy[eventName];
    
    [invocation setArgument:&userInfo atIndex:2];
    
    [invocation invoke];
    
    // 如果需要让事件继续往上传递，则调用下面的语句 (+ 责任链（响应脸）模式（多响应） + Decorator(组合))
    // [super routerEventWithName:eventName userInfo:userInfo];
}


//self.eventStrategy是一个字典，这个字典以eventName作key，对应的处理逻辑封装成NSInvocation来做value。

- (NSDictionary <NSString *, NSInvocation *> *)eventStrategy
{
    if (_eventStrategy == nil) {
        _eventStrategy = @{
                           oneEvent:[self createInvocationWithSelector:@selector(ticketEvent:)],
                           twoEvent:[self createInvocationWithSelector:@selector(promotionEvent:)],
                           threeEvent:[self createInvocationWithSelector:@selector(scoreEvent:)],
                           };
    }
    return _eventStrategy;
}

-(NSInvocation *)createInvocationWithSelector:(SEL)selector{
    
    NSMethodSignature*signature = [[self class] instanceMethodSignatureForSelector:@selector(selector)];
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = @selector(selector);
    return invocation;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
