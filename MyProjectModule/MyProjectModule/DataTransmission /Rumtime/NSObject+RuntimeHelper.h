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
   - __weak 本身就会把指针指向nil，那直接利用就是了。使用OBJC_ASSOCIATION_COPY关联策略将block copy到堆上，利用block把持有的weak对象返回，如果对象不存在了，返回的便是空值
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
