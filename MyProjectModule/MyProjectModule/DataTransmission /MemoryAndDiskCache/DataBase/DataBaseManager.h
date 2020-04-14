//
//  DataBaseManager.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 表间
 */

@interface DataBaseManager : NSObject

+ (DataBaseManager*)sharedManager;

//建表操作
- (void)createTable:(NSString *)tableName,...;

//创建触发器,是表级联动，要删都删，要改都改，要插都插，所以这是他们的通行
- (void)insertTriggerOnClass:(Class)onItemClass attachToClass:(Class)toItemClass useOnClassPropertyNames:(NSArray*)onArray insertToClassPropertyNames:(NSArray*)toArray;

- (void)updateTriggerOnClass:(Class)onItemClass toClass:(Class)toItemClass useOnClassPropertyNames:(NSArray*)onArray updateToClassPropertyNames:(NSArray*)toArray;

- (void)deleteTriggerOnClass:(Class)onItemClass toClass:(Class)toItemClass useOnClassPropertyNames:(NSArray*)onArray deleteToClassPropertyNames:(NSArray*)toArray;

- (void)upgradeDataBase;

@end
