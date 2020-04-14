//
//  DBAbstractItem+Sql.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "DBAbstractItem.h"

@interface DBAbstractItem (Sql)

+ (NSString*)objectName;

//建表
+ (NSString*)createTableSql;

//删表
+ (NSString*)deleteTableSql;

//清空表
+ (NSString*)emptySql;

//插入
- (NSString*)insertSql;
- (NSString*)insertSqlPropertyNames:(NSArray*)propertyNameArray;

//删除
- (NSString*)deleteSql;
- (NSString*)deleteWithEqualArray:(NSArray*)equalArray;

- (NSString*)deleteWithEqualPropertyNames:(NSArray*)propertyNamesArray;

//根据条件删除
- (NSString*)deleteWithConditionString:(NSString*)string;

//修改
- (NSString*)updateSql;
- (NSString*)updateSqlWithEqualArray:(NSArray*)equalArray;

//查找
- (NSString*)selectSqlIsAll:(BOOL)isAll;
- (NSString*)seleleCountSql;
- (NSString*)selectSqlWithConditionString:(NSString*)conditionString;
- (NSString*)selectSqlWithEqualArray:(NSArray*)propertyNames;//根据属性相等去查找

@end
