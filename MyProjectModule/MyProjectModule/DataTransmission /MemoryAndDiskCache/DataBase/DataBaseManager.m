//
//  DataBaseManager.m
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DataBaseManager.h"

#import <UIKit/UIKit.h>

#import "DataBaseConfig.h"


#import "SqliteDataBase.h"

#import "DBAbstractItem+Sql.h"

static NSString *DataBaseVersionNum = @"DataBaseVersionNum";

@implementation DataBaseManager

#pragma mark- 建表

- (void)createTable:(NSString *)tableName,...
{
    NSMutableArray *tableNameArray = [NSMutableArray new];
    va_list args;
    va_start(args, tableName);
    if (tableName)
    {
        [tableNameArray addObject:tableName];
        NSString *otherTableName;
        while ((otherTableName = va_arg(args, NSString *)))
        {
            //依次取得所有参数
            if (!otherTableName.length) {
                continue;
            }
            [tableNameArray addObject:otherTableName];
        }
    }
    va_end(args);
    
    for (NSString *tableName in tableNameArray) {
        Class class = NSClassFromString(tableName);
        [[SqliteDataBase sharedSqliteDataBase] executeUpdate:[class createTableSql]];
    }
}

#pragma mark- 触发器

/*
 CREATE TRIGGER audit_log AFTER INSERT
 ON COMPANY
 BEGIN
 INSERT INTO AUDIT(EMP_ID, ENTRY_DATE) VALUES (new.ID, datetime('now'));
 END;
 */

- (void)insertTriggerOnClass:(Class)onItemClass attachToClass:(Class)toItemClass useOnClassPropertyNames:(NSArray*)onArray insertToClassPropertyNames:(NSArray*)toArray
{
    NSString *triggerName = [NSString stringWithFormat:@"%@_%@_insert",NSStringFromClass(onItemClass),NSStringFromClass(toItemClass)];
    
    NSString *onTableName = [NSString stringWithFormat:@"%@Table",NSStringFromClass(onItemClass)];
    NSString *toTableName = [NSString stringWithFormat:@"%@Table",NSStringFromClass(toItemClass)];
    
    NSString *toClassInsertPropertys = [toArray componentsJoinedByString:@","] ;

    NSString *onClassValueString = [self joinToArrayValue:onArray];
    
//     NSString *sql = [NSString stringWithFormat:@"CREATE TRIGGER audit_log AFTER INSERT ON COMPANY BEGIN INSERT INTO ADULT(EMP_ID, ENTRYDATE) VALUES (new.ID, datetime('now')); END"];
    
    NSString *sql = @"create trigger %@ after insert \
                        on %@ for each row \
                      begin   \
    insert into %@(%@) values (%@); \
                        end    \
                      ";
    
    sql = [NSString stringWithFormat:sql,triggerName,onTableName,toTableName,toClassInsertPropertys ,onClassValueString];
    
    [[SqliteDataBase sharedSqliteDataBase] executeUpdate:sql];
}


- (void)updateTriggerOnClass:(Class)onItemClass toClass:(Class)toItemClass useOnClassPropertyNames:(NSArray*)onArray updateToClassPropertyNames:(NSArray*)toArray
{
    NSString *triggerName = [NSString stringWithFormat:@"%@_%@_update",NSStringFromClass(onItemClass),NSStringFromClass(toItemClass)];
    
    NSString *onTableName = [NSString stringWithFormat:@"%@Table",NSStringFromClass(onItemClass)];
    NSString *toTableName = [NSString stringWithFormat:@"%@Table",NSStringFromClass(toItemClass)];
    
    NSString *setPropertyValue = [self joinToPropertyNameArray:toArray onPropertyNameValue:onArray];

    NSString *sql = @"create trigger %@ after update \
    on %@ for each row \
    begin   \
    update %@ set %@ ;\
    end    \
    ";
    sql = [NSString stringWithFormat:sql,triggerName,onTableName,toTableName,setPropertyValue ];
    [[SqliteDataBase sharedSqliteDataBase] executeUpdate:sql];
}


- (void)deleteTriggerOnClass:(Class)onItemClass toClass:(Class)toItemClass useOnClassPropertyNames:(NSArray*)onArray deleteToClassPropertyNames:(NSArray*)toArray
{
    NSString *triggerName = [NSString stringWithFormat:@"%@_%@_delete",NSStringFromClass(onItemClass),NSStringFromClass(toItemClass)];
    
    NSString *onTableName = [NSString stringWithFormat:@"%@Table",NSStringFromClass(onItemClass)];
    NSString *toTableName = [NSString stringWithFormat:@"%@Table",NSStringFromClass(toItemClass)];
    
    NSString *whereCondition = [self joinToPropertyNameArray:toArray onPropertyNameValue:onArray];
    
   
    
    NSString *sql = @"create trigger %@ after delete \
    on %@ for each row \
    begin   \
    delete from %@ where %@ \
    ;end    \
    ";
    
    sql = [NSString stringWithFormat:sql,triggerName,onTableName,toTableName,whereCondition];
    [[SqliteDataBase sharedSqliteDataBase] executeUpdate:sql];
}


- (NSString*)joinToArrayValue:(NSArray*)array
{
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSString *propertyName in array) {
        NSString *tempString = [NSString stringWithFormat:@"new.%@",propertyName];
        [tempArray addObject:tempString];
    }
    return [tempArray componentsJoinedByString:@","];
}

- (NSString*)joinToPropertyNameArray:(NSArray*)toArray onPropertyNameValue:(NSArray*)onArray
{
    NSMutableArray *tempArray = [NSMutableArray new];
    
    int i =0 ;
    
    for (NSString *propertyName in onArray) {
        
        NSString *tempString = [NSString stringWithFormat:@"new.%@",propertyName];
        
        
        tempString = [NSString stringWithFormat:@"%@=%@",[toArray objectAtIndex:i],tempString];
        
        [tempArray addObject:tempString];
        
        i++;
    }
    return [tempArray componentsJoinedByString:@","];
}


- (void)upgradeDataBase
{
    NSNumber *versionNum =  [[NSUserDefaults standardUserDefaults] objectForKey:DataBaseVersionNum];
    if (versionNum==nil) {
        [[SqliteDataBase sharedSqliteDataBase] upgradeDataBase];
        [[NSUserDefaults standardUserDefaults] setObject:@(DB_Version_Num) forKey:DataBaseVersionNum];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    if (versionNum.integerValue == DB_Version_Num) {
        return;
    }
    if (versionNum.integerValue<DB_Version_Num) {
        
        [[SqliteDataBase sharedSqliteDataBase] upgradeDataBase];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(DB_Version_Num) forKey:DataBaseVersionNum];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


#pragma mark- 初始化

- (id)init
{
    self = [super init];
    return self;
}

+ (SqliteDataBase*)sharedManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}


@end
