//
//  NSObject+RuntimeHelper.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeHelper)


 /// 消息机制
-(void)sendMessage;


/// RunTime增加方法 利用到resolveInstanceMethod
-(void)runTimeAddInstanceMethod;


/// 交换方法
+ (void)pxy_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

///  消息转发




///  动态关联属性
/** 1: 给 Category 添加 weak 属性
   - 思路是这样的，让需要被 weak 修饰的对象去持有一个 strong 的对象，然后当被修饰的对象被释放的时候，持有的对象也会被释放，那么我们就可以捕捉到释放的事件，进而使用OBJC_ASSOCIATION_ASSIGN 来实现弱引用，在释放事件里面再将其释放掉，进而实现weak功能。
   [添加weak属性](https://www.jianshu.com/p/18d8cd4ff6c6)
   - 大题思路就是 引入中间对象
*/
@property (nonatomic, weak) id objc_weak_id;




/// 获取类中的所有属性
- (void)pxy_printPropertyList;

/// 获取类中的所有成员变量
- (void)pxy_printIvaList;


/// 获取类中的所有方
- (void)pxy_printMethodList;

/// 获取协议列表
- (void)pxy_printProtocolList;

/// 动态创建类和对象
 
/// 私有属性的访问与修改

@end
