//
//  cellModel.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CellModel.h"
#import <objc/runtime.h>

@implementation CellModel
- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}
- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    CellModel *abstractItem = [[[self class] allocWithZone:zone] init];
    unsigned int count;
    objc_property_t *property= class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char *properName =  property_getName(property[i]);
        NSString *key= [NSString stringWithUTF8String:properName];
        [abstractItem setValue:[self valueForKey:key] forKey:key];
    }
    free(property);
    return abstractItem;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:name];
        //归档到文件中
        [aCoder encodeObject:value forKey:name];
    }
    free(propertes);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count =0;
        //1.取出所有的属性
        objc_property_t *propertes = class_copyPropertyList([self class], &count);
        //2.遍历所有的属性
        for (int i = 0; i < count; i++) {
            //获取当前遍历到的属性名称
            const char *propertyName = property_getName(propertes[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            //解归档前遍历得到的属性的值
            id value = [aDecoder decodeObjectForKey:name];
            [self setValue:value forKey:name];
        }
        free(propertes);
    }
    return self;
}

@end
