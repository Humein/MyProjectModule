//
//  DBAbstractItem.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,DataType){
    Integer,//(int integer Int2 int8等)
    Real,//(double,float double precision)
    Text//(character(20) varchar(255),text)
};

//数据库的抽象类

@interface DBAbstractItem : NSObject<NSCopying,NSMutableCopying,NSCoding>

/*下面都是一些基本的信息设置，我们务必要填充，为了提高数据库的查询效率*/

// 主键
+ (NSString*)primaryKey;

//要存贮的实体，我们要存哪些字段
+ (NSArray*)requireProperties;

//要存贮的实体，对应的字段的类型
+ (NSArray*)requirePropertTypes;

//把存贮字段和类型匹配的一个字典，属性字段做key,类型做value
+ (NSDictionary*)propertyNamesWithTypes;

//这个是共外界用
+ (NSArray*)requerePropertyStringTypes;

@end
