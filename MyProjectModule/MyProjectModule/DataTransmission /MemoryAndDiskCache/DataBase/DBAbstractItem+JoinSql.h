//
//  DBAbstractItem+JoinSql.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DBAbstractItem.h"

@interface DBAbstractItem (JoinSql)

+ (NSString*)joinPropertyNameTypeToCreateTable;

//属性拼接
- (NSString*)joinPropertyName;

//值拼接
- (NSString*)joinPropertyValue;

//拼接一个属性的数组
- (NSString*)joinPropertyNameArray:(NSArray*)propertyNameArray;

//拼接一个值的数组
- (NSString*)joinPropertyValueArrayFromPropertyNameArray:(NSArray*)propertyNameArray;

//拼接key和value的处理
- (NSString*)joinKeyAndValue:(NSArray*)propertyNameArray;

- (NSString*)whereKeyToValue;

@end
