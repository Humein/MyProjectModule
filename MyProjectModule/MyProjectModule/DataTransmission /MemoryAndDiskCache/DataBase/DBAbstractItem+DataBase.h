//
//  DBAbstractItem+DataBase.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//
#import "DBAbstractItem.h"

@interface DBAbstractItem (DataBase)

//增
- (void)insertItem;
+ (void)insertItems:(NSArray*)items;

//删
- (void)deleteItem;
+ (void)deleteItems:(NSArray*)items;
+ (void)deletedbItem:(id)item equealArray:(NSArray*)equealArray;//这个方法过于面向对象
//按照条件删除,直接传入响应的属性和字段
+ (void)deletedbItem:(id)item equalPropertyNames:(NSArray *)equealArray;
//按照条件删除
+ (void)deleteItemWhereCondition:(NSString*)coditionString;

//改
- (void)updateItem;
- (void)updateItemSetpropertyNameArray:(NSArray*)nameArray;
+ (void)updateItems:(NSArray*)items;

//查
- (void)selectItem:(void (^)(DBAbstractItem *item))block;
//按照条件查找
- (void)selectItemWithEqualPropertyNames:(NSArray*)propertyNames completionBlock:(void(^)(NSArray* resultArray))block;

- (void)selectItemCount:(void(^)(NSInteger count))block;

+ (void)selectItemAll:(void (^)(NSArray *resultArray))block;

+ (void)selectdbWhereCondition:(NSString*)conditionString completionBlock:(void(^)(NSArray *resultArray))block;


@end
