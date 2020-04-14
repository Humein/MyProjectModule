//
//  DBAbstractItem+Sql.m
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DBAbstractItem+Sql.h"

#import "DBAbstractItem+JoinSql.h"

@implementation DBAbstractItem (Sql)

//建表
+ (NSString*)createTableSql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",[self objectName]];
    NSString *createSql=[self joinPropertyNameTypeToCreateTable];
    NSString *sql=[NSString stringWithFormat:@"create table if not exists %@ (%@)",tableName,createSql];
    return sql;
}

//删表
+ (NSString*)deleteTableSql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",[self objectName]];
    NSString *sql=[NSString stringWithFormat:@"drop table %@",tableName];
    return sql;
}

//清空表
+ (NSString*)emptySql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",[self objectName]];
    NSString *sql=[NSString stringWithFormat:@"delete from %@",tableName];
    return sql;
}

//插入
- (NSString*)insertSql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",[[self class] objectName]];
    NSString *sql=[NSString stringWithFormat:@"insert or replace into %@ (%@) values (%@)",tableName,[self joinPropertyName],[self joinPropertyValue]];
    return sql;
}

- (NSString*)insertSqlPropertyNames:(NSArray*)propertyNameArray
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",[[self class] objectName]];
    NSString *sql=[NSString stringWithFormat:@"insert or replace into %@ (%@) values (%@)",tableName,[self joinPropertyNameArray:propertyNameArray],[self joinPropertyValueArrayFromPropertyNameArray:propertyNameArray]];
    return sql;
}

//删除
- (NSString*)deleteSql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",[[self class] objectName]];
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@",tableName,[self whereKeyToValue]];
    
    return sql;
}


- (NSString*)deleteWithEqualArray:(NSArray*)equalArray
{    
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    
    NSString *sql=[NSString stringWithFormat:@"delete from %@ where %@",tableName,[equalArray componentsJoinedByString:@"and"]];
    return sql;
}


- (NSString*)deleteWithEqualPropertyNames:(NSArray*)propertyNamesArray
{
    //这个是属性的名字
    NSMutableArray *tmpArray = [NSMutableArray new];
    
    for (NSString *propertyName in propertyNamesArray) {
        
        id value= [self valueForKey:propertyName];
        
        if ([value isKindOfClass:[NSString class]]) {
            value= [NSString stringWithFormat:@"'%@'",value];
        }else{
            value = [NSString stringWithFormat:@"%@",value];
        }
        [tmpArray addObject:value];
    }
    
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    
    NSString *sql=[NSString stringWithFormat:@"delete from %@ where %@",tableName,[tmpArray componentsJoinedByString:@"and"]];
    
    return sql;
}

- (NSString*)deleteWithConditionString:(NSString*)string
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    
    NSString *sql=[NSString stringWithFormat:@"delete from %@ where %@",tableName,string];
    
    return sql;
}


- (NSString*)updateSql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    NSString *updateSql = [self joinKeyAndValue:[[self class] requireProperties]];
    NSString *sql=[NSString stringWithFormat:@"update %@ set %@ where %@",tableName,updateSql,[self whereKeyToValue]];
    return sql;
}


- (NSString*)updateSqlWithEqualArray:(NSArray*)equalArray
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    NSString *updateSql = [self joinKeyAndValue:equalArray];
    NSString *sql=[NSString stringWithFormat:@"update %@ set %@ where %@",tableName,updateSql,[self whereKeyToValue]];
    return sql;
}


- (NSString*)selectSqlIsAll:(BOOL)isAll
{
    NSString *sql = nil;
    
    if (isAll) {
       
        NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
        sql=[NSString stringWithFormat:@"select * from %@ ",tableName];
    }else{
        
        NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
        sql=[NSString stringWithFormat:@"select * from %@ where %@",tableName,[self whereKeyToValue]];
    }
    return sql;
}

- (NSString*)seleleCountSql
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    NSString *sql=[NSString stringWithFormat:@"select count(*) from %@ ",tableName];
    
    return sql;
}

- (NSString*)selectSqlWithConditionString:(NSString*)conditionString
{
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    NSString *sql=[NSString stringWithFormat:@"select * from %@ where %@",tableName,conditionString];
    return sql;
}

- (NSString*)selectSqlWithEqualArray:(NSArray*)propertyNames
{
    //这个是属性的名字
    NSMutableArray *tmpArray = [NSMutableArray new];

    for (NSString *propertyName in propertyNames) {
        
        id value= [self valueForKey:propertyName];
        
        if ([value isKindOfClass:[NSString class]]) {
            value= [NSString stringWithFormat:@"'%@'",value];
        }else{
            value = [NSString stringWithFormat:@"%@",value];
        }
        [tmpArray addObject:value];
    }
    
    NSString *tableName=[NSString stringWithFormat:@"%@Table",NSStringFromClass([self class])];
    
    NSString *sql=[NSString stringWithFormat:@"select * from %@ where %@",tableName,[tmpArray componentsJoinedByString:@"and"]];
    
    return sql;
}

#pragma mark- 辅助功能

+ (NSString*)objectName{
    NSString *className = NSStringFromClass([self class]);
    // 适配swift类
    NSArray *array = [className componentsSeparatedByString:@"."];
    return array.lastObject;
}



@end
