//
//  DBAbstractItem.m
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DBAbstractItem.h"
#import <objc/runtime.h>

/**
 - 利用运行时的class_getProperty方法和KVC机制构造对象，返回给外部对象，而不是FMDB直接返回的数据

 */

@implementation DBAbstractItem

// 主键
+ (NSString*)primaryKey
{
    return nil;
//    return @"indentifyKey";
}

//要存贮的实体，我们要存哪些字段
+ (NSArray*)requireProperties
{
    return nil;
    
//     return @[@"programID",@"goodsID",@"userID",@"giftKey",@"starttime",@"countNum"];
}

//要存贮的实体，对应的字段的类型
+ (NSArray*)requirePropertTypes
{
    return nil;
    
//    return @[@2,@1,@2,@2,@0,@0];
}



+ (NSDictionary*)propertyNamesWithTypes
{
    return nil;
    
//    return @{@"programID":@2,@"goodsID":@1,@"userID":@2,@"giftKey":@2,@"starttime":@0,@"countNum":@0};
}


+ (NSArray*)requerePropertyStringTypes
{
    NSMutableArray *typeArray= [NSMutableArray new];
    
    NSArray *array= [self requirePropertTypes];
    
    for (NSNumber *number in array) {
        
        switch (number.integerValue) {
            case 0:
            {
                [typeArray addObject:@"integer"];
            }
                break;
            case 1:
            {
                [typeArray addObject:@"float"];
            }
                break;
                
            case 2:
            {
                [typeArray addObject:@"Text"];
            }
                break;
            default:
                break;
        }
    }
    return typeArray;
}



- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    DBAbstractItem *abstractItem = [[[self class] allocWithZone:zone] init];
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
