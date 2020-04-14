//
//  DBAbstractItem+DataBase.m
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DBAbstractItem+DataBase.h"

#import "SqliteDataBase.h"

@implementation DBAbstractItem (DataBase)

//增
- (void)insertItem
{
    [[SqliteDataBase sharedSqliteDataBase] insertdbItem:self];
}

+ (void)insertItems:(NSArray*)items
{
    [[SqliteDataBase sharedSqliteDataBase] insertdbItems:items];
}

+ (void)deletedbItem:(id)item equealArray:(NSArray*)equealArray {
    [[SqliteDataBase sharedSqliteDataBase] deletedbItem:item equealArray:equealArray];
}

//按照条件删除,直接传入响应的属性和字段
+ (void)deletedbItem:(id)item equalPropertyNames:(NSArray *)equealArray
{
    [[SqliteDataBase sharedSqliteDataBase] deletedbItem:item equealPropertyNames:equealArray];
}

//删
- (void)deleteItem
{
    [[SqliteDataBase sharedSqliteDataBase] deletedbItem:self];
}

+ (void)deleteItems:(NSArray*)items
{
    [[SqliteDataBase sharedSqliteDataBase] deletedbItems:items];
}

+ (void)deleteItemWhereCondition:(NSString*)coditionString
{
    DBAbstractItem *item = [[[self class] alloc] init];
    
    [[SqliteDataBase sharedSqliteDataBase] deletedbItem:item conditonString:coditionString];
    
}

//改
- (void)updateItem
{
    [[SqliteDataBase sharedSqliteDataBase] updatedbItem:self];
}

- (void)updateItemSetpropertyNameArray:(NSArray*)nameArray
{
    [[SqliteDataBase sharedSqliteDataBase] updatedbItem:self equealArray:nameArray];
}

+ (void)updateItems:(NSArray*)items
{
    [[SqliteDataBase sharedSqliteDataBase] updatedbItems:items];
}


//查
- (void)selectItem:(void (^)(DBAbstractItem *item))block
{
    [[SqliteDataBase sharedSqliteDataBase] selectdbItem:self completionBlock:^(id item) {
        
         block ? block (item) : nil;
    }];
}

//按照条件查找
- (void)selectItemWithEqualPropertyNames:(NSArray*)propertyNames completionBlock:(void(^)(NSArray* resultArray))block
{
    [[SqliteDataBase sharedSqliteDataBase] selectdbItem:self equalPropertyNames:propertyNames completionBlock:^(NSArray *items) {
        
         block ? block (items) : nil;
        
    }];
    
}


- (void)selectItemCount:(void(^)(NSInteger count))block
{
    [[SqliteDataBase sharedSqliteDataBase] selectdbItemCount:self completionBlock:^(int count) {
        
         block ? block (count) : nil;
    }];
}

+ (void)selectItemAll:(void (^)(NSArray *resultArray))block
{
    
    DBAbstractItem *item = [[[self class] alloc] init];
    
    [[SqliteDataBase sharedSqliteDataBase] selectdbAllItem:item completionblock:^(NSArray *items) {
        
        block ? block (items) : nil;
    }];
}

+ (void)selectdbWhereCondition:(NSString*)conditionString completionBlock:(void(^)(NSArray *resultArray))block {
    
    DBAbstractItem *item = [[[self class] alloc] init];
    
    [[SqliteDataBase sharedSqliteDataBase] selectdbItem:item whereCondition:conditionString completionBlock:^(NSArray *items) {
        block ? block (items) : nil;
    }];
    
}


@end
