//
//  SqliteDataBase.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *DataBasePath = @"benkelaile.db";

@interface SqliteDataBase : NSObject

+ (id)sharedSqliteDataBase;
- (void)upgradeDataBase;

//执行指令
- (void)executeUpdate:(NSString*)sqlString;
- (void)executeQuery:(NSString*)sqlString forItem:(Class)itemClass completionBlock:(void(^)(NSArray* resultArray))resultBlock;

//插入操作，插入就是直接插入操作
- (void)insertdbItem:(id)item ;
- (void)insertdbItem:(id)item propertyNames:(NSArray*)propertyNameArray;
- (void)insertdbItems:(NSArray*)itemArray;
- (void)insertdbItems:(NSArray*)itemArray propertyNames:(NSArray*)propertyNameArray;

//删除操作
- (void)deletedbItem:(id)item;
- (void)deletedbItem:(id)item equealArray:(NSArray*)equealArray;
- (void)deletedbItems:(NSArray*)itemArray;
- (void)deletedbItems:(NSArray*)itemArray equealArray:(NSArray*)equealArray;
//根据属性来删除，
- (void)deletedbItem:(id)item equealPropertyNames:(NSArray *)equealArray;
//根据条件删除
- (void)deletedbItem:(id)item conditonString:(NSString*)string;

//更新操作
- (void)updatedbItem:(id)item;
- (void)updatedbItem:(id)item equealArray:(NSArray*)equealArray;
- (void)updatedbItems:(NSArray*)itemArray;
- (void)updatedbItems:(NSArray*)itemArray equealArray:(NSArray*)equealArray;

//查找操作
- (void)selectdbItem:(id)item completionBlock:(void(^)(id item))block;
- (void)selectdbAllItem:(id)item completionblock:(void(^)(NSArray *items))block;
- (void)selectdbItemCount:(id)item completionBlock:(void(^)(int count))block;

- (void)selectdbItem:(id)item equalPropertyNames:(NSArray*)propertyNames completionBlock:(void (^)(NSArray *items))block;

- (void)selectdbItem:(id)item whereCondition:(NSString*)conditionString completionBlock:(void(^)(NSArray *items))block;

@end
