//
//  NSObject+RuntimeNSCodingHelper.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PXYNSCodingRuntime_EncodeWithCoder(Class) \
unsigned int outCount = 0;\
Ivar *ivars = class_copyIvarList([Class class], &outCount);\
for (int i = 0; i < outCount; i++) {\
Ivar ivar = ivars[i];\
NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
[aCoder encodeObject:[self valueForKey:key] forKey:key];\
}\
free(ivars);\
\

#define PXYNSCodingRuntime_InitWithCoder(Class)\
if (self = [super init]) {\
unsigned int outCount = 0;\
Ivar *ivars = class_copyIvarList([Class class], &outCount);\
for (int i = 0; i < outCount; i++) {\
Ivar ivar = ivars[i];\
NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
id value = [aDecoder decodeObjectForKey:key];\
if (value) {\
[self setValue:value forKey:key];\
}\
}\
free(ivars);\
}\
return self;\
\

/**
 利用 class_copyIvarList 实现 NSCoding 的自动归档解档
 在利用 NSKeyedArchiver 归档解档对象的时候，对象 Model 需要实现 NSCoding 协议，并且要实现 encodeWithCoder、initWithCoder 两个方法，在这两个方法中要为每个属性进行 code 和 encode，不然就会 crash。
 
 在项目开发过程中，经常会出现 Model 中的属性会变更，这个时候总是会忘记去修改对应的属性 code 和 encode，这里就会导致 crash；为了避免这个现象和让 Model 中的方法更加简洁可控，这里我们会利用 class_copyIvarList 来获取对象中的成员变量列表，然后利用 KVC 来 code 和 encode。实例代码如下：(这里我们将这个通用的代码抽象成宏，这样子在需要的 Model 中直接调用就可以了)
 
 code 和 encode 缓存model
 
 
 利用 Runtime 实现自动归档 & 解档

 */
@interface AbstractItem : NSObject<NSCopying,NSMutableCopying,NSCoding>

@property (nonatomic,assign)float itemHeight;

@property (nonatomic,assign)float itemWidth;

@end
