//
//  SqliteDataBase.m
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "SqliteDataBase.h"

#import "FMDB.h"

#import "DBAbstractItem.h"

#import "DBAbstractItem+Sql.h"

@interface SqliteDataBase ()
/**
 - FMDB 提供了 FMDatabaseQueue 在多线程环境下操作数据库，它内部维护了一个串行队列来保证线程安全 [从FMDB线程安全问题说起](https://crmo.github.io/2019/01/28/%E4%BB%8EFMDB%E7%BA%BF%E7%A8%8B%E5%AE%89%E5%85%A8%E9%97%AE%E9%A2%98%E8%AF%B4%E8%B5%B7/)
  
 */
@property (nonatomic,strong)FMDatabaseQueue *dataBaseQueue;

@property (nonatomic,strong)dispatch_queue_t operationQueue;

@end


@implementation SqliteDataBase

#pragma mark- 指令执行
- (void)executeUpdate:(NSString*)sqlString
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            BOOL isSuccess =[db executeUpdate:sqlString];
            isSuccess ? (NSLog(@"执行指令成功")) : (NSLog(@"执行指令失败"));
        }];
    });
}

- (void)executeQuery:(NSString*)sqlString forItem:(Class)itemClass completionBlock:(void(^)(NSArray* resultArray))resultBlock
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSMutableArray *resultArray = [NSMutableArray new];
            FMResultSet *rs=[db executeQuery:sqlString];
            NSArray *propertyNameArray=[itemClass requireProperties];
            while ([rs next]) {
                id tempItem=[[itemClass alloc] init];
                for (NSString *propertyName in propertyNameArray) {
                    id value=[rs objectForColumn:propertyName];
                    [tempItem setValue:value forKey:propertyName];
                }
                [resultArray addObject:tempItem];
            }
            resultBlock ? resultBlock (resultArray) : nil;
        }];
    });
}


#pragma mark- 插入操作
- (void)insertdbItem:(id)item
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *insertSql=[item insertSql];
            BOOL isSuccess = [db executeUpdate:insertSql];
            isSuccess ? (NSLog(@"插入成功")) : (NSLog(@"插入失败"));
        }];
    });
}

- (void)insertdbItem:(id)item propertyNames:(NSArray *)propertyNameArray
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *insertSql=[item insertSqlPropertyNames:propertyNameArray];
            BOOL isSuccess = [db executeUpdate:insertSql];
            isSuccess ? (NSLog(@"插入成功")) : (NSLog(@"插入失败"));
        }];
    });
}


- (void)insertdbItems:(NSArray*)itemArray
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            BOOL isRollBack=NO;
            @try {
                for (id item in itemArray) {
                    NSString *insertSql=[item insertSql];
                    [db executeUpdate:insertSql];
                }
            }
            @catch (NSException *exception) {
                isRollBack=YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }];
        
    });
    
    
}

- (void)insertdbItems:(NSArray *)itemArray propertyNames:(NSArray *)propertyNameArray
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            BOOL isRollBack=NO;
            @try {
                for (id item in itemArray) {
                    NSString *insertSql=[item insertSqlPropertyNames:propertyNameArray];
                    [db executeUpdate:insertSql];
                }
            }
            @catch (NSException *exception) {
                isRollBack=YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }];
    });
}

#pragma mark- 删除操作
- (void)deletedbItem:(id)item
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *deleteSql=[item deleteSql];
            BOOL isSuccess = [db executeUpdate:deleteSql];
            isSuccess ? (NSLog(@"删除成功")) : (NSLog(@"删除失败"));
        }];
        
    });
}
- (void)deletedbItem:(id)item equealArray:(NSArray*)equealArray
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *deleteSql=[item deleteWithEqualArray:equealArray];
            BOOL isSuccess = [db executeUpdate:deleteSql];
            isSuccess ? (NSLog(@"删除成功")) : (NSLog(@"删除失败"));
        }];
    });
}

- (void)deletedbItem:(id)item equealPropertyNames:(NSArray *)equealArray
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *deleteSql=[item deleteWithEqualPropertyNames:equealArray];
            BOOL isSuccess = [db executeUpdate:deleteSql];
            isSuccess ? (NSLog(@"删除成功")) : (NSLog(@"删除失败"));
        }];
    });
}

- (void)deletedbItem:(id)item conditonString:(NSString*)string
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSString *deleteSql=[item deleteWithConditionString:string];
            BOOL isSuccess = [db executeUpdate:deleteSql];
            isSuccess ? (NSLog(@"删除成功")) : (NSLog(@"删除失败"));
        }];
    });
}


- (void)deletedbItems:(NSArray*)itemArray
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            BOOL isRollBack=NO;
            @try {
                for (id item in itemArray) {
                    NSString *deleteSql=[item deleteSql];
                    [db executeUpdate:deleteSql];
                }
            }
            @catch (NSException *exception) {
                isRollBack=YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }];
    });
    
}

- (void)deletedbItems:(NSArray*)itemArray equealArray:(NSArray*)equealArray
{
    dispatch_async(self.operationQueue, ^{
        [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            BOOL isRollBack=NO;
            @try {
                for (id item in itemArray) {
                    NSString *deleteSql=[item deleteWithEqualArray:equealArray];
                    [db executeUpdate:deleteSql];
                }
            }
            @catch (NSException *exception) {
                isRollBack=YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }];
        
    });
}




#pragma mark- 更新操作
- (void)updatedbItem:(id)item
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *updateSql=[item updateSql];
            BOOL isSuccess = [db executeUpdate:updateSql];
            isSuccess ? (NSLog(@"更新成功")) : (NSLog(@"更新失败"));
        }];
    });
    
    
}

- (void)updatedbItem:(id)item equealArray:(NSArray*)equealArray
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *updateSql=[item updateSqlWithEqualArray:equealArray];
            BOOL isSuccess = [db executeUpdate:updateSql];
            isSuccess ? (NSLog(@"更新成功")) : (NSLog(@"更新失败"));
        }];
    });
    
}

- (void)updatedbItems:(NSArray*)itemArray
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            BOOL isRollBack=NO;
            @try {
                for (id item in itemArray) {
                    NSString *updateSql=[item updateSql];
                    [db executeUpdate:updateSql];
                }
            }
            @catch (NSException *exception) {
                isRollBack=YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }];
    });
    
}

- (void)updatedbItems:(NSArray*)itemArray equealArray:(NSArray*)equealArray
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            BOOL isRollBack=NO;
            @try {
                for (id item in itemArray) {
                    NSString *updateSql=[item updateSqlWithEqualArray:equealArray];
                    [db executeUpdate:updateSql];
                }
            }
            @catch (NSException *exception) {
                isRollBack=YES;
                [db rollback];
            }
            @finally {
                if (!isRollBack) {
                    [db commit];
                }
            }
        }];
    });
    
}


#pragma mark- 查找
- (void)selectdbItem:(id)item completionBlock:(void(^)(id item))block
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSString *selectSql=[item selectSqlIsAll:NO];
            
            FMResultSet *rs=[db executeQuery:selectSql];
            
            NSArray *propertyNameArray=[[item class] requireProperties];
            
            id tempItem= nil;
            
            while ([rs next]) {
                
                tempItem=[[[item class] alloc] init];
                for (NSString *propertyName in propertyNameArray) {
                    
                    id value=[rs objectForColumn:propertyName];
                    [tempItem setValue:value forKey:propertyName];
                }
                break;
            }
             block ? block (tempItem) : nil;
            [rs close];
        }];
    });
    
    
}

- (void)selectdbAllItem:(id)item completionblock:(void(^)(NSArray *items))block
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *selectSql=[item selectSqlIsAll:YES];
            
            FMResultSet *rs=[db executeQuery:selectSql];
            
            NSArray *propertyNameArray=[[item class] requireProperties];
            
            NSMutableArray *resultArray=[NSMutableArray arrayWithCapacity:0];
            
            while ([rs next]) {
                id tempItem=[[[item class] alloc] init];
                for (NSString *propertyName in propertyNameArray) {
                    id value=[rs objectForColumn:propertyName];
                    [tempItem setValue:value forKey:propertyName];
                }
                [resultArray addObject:tempItem];
            }
            block ? block (resultArray) : nil;
            
            [rs close];
        }];
    });
    
}

- (void)selectdbItemCount:(id)item completionBlock:(void(^)(int count))block
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSString *selectSql=[item seleleCountSql];
            
            int count = [db intForQuery:selectSql];
            
            block ? block (count) : nil;
        }];
    });
    
}

- (void)selectdbItem:(id)item equalPropertyNames:(NSArray*)propertyNames completionBlock:(void (^)(NSArray *items))block
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSString *selectSql=[item selectSqlWithEqualArray:propertyNames];
            
            FMResultSet *rs=[db executeQuery:selectSql];
            
            NSArray *propertyNameArray=[[item class] requireProperties];
            
            NSMutableArray *resultArray=[NSMutableArray arrayWithCapacity:0];
            
            while ([rs next]) {
                
                id tempItem=[[[item class] alloc] init];
                for (NSString *propertyName in propertyNameArray) {
                    id value=[rs objectForColumn:propertyName];
                    [tempItem setValue:value forKey:propertyName];
                }
                [resultArray addObject:tempItem];
            }
            
            block ? block (resultArray) : nil;
            [rs close];
            
        }];
    });
}

- (void)selectdbItem:(id)item whereCondition:(NSString*)conditionString completionBlock:(void(^)(NSArray *items))block
{
    dispatch_async(self.operationQueue, ^{
        
        [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSString *selectSql=[item selectSqlWithConditionString:conditionString];
            
            FMResultSet *rs=[db executeQuery:selectSql];
            
            NSArray *propertyNameArray=[[item class] requireProperties];
            
            NSMutableArray *resultArray=[NSMutableArray arrayWithCapacity:0];
            
            while ([rs next]) {
                
                id tempItem=[[[item class] alloc] init];
                for (NSString *propertyName in propertyNameArray) {
                    id value=[rs objectForColumn:propertyName];
                    [tempItem setValue:value forKey:propertyName];
                }
                [resultArray addObject:tempItem];
            }
            block ? block (resultArray) : nil;
            [rs close];
        }];
    });
    
}



#pragma mark- 这个是初始化的一些参数配置
+ (NSString*)customerDataBasePath:(NSString *)dataBaseName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *DBPath = [documentDirectory stringByAppendingPathComponent:dataBaseName];
    return DBPath;
}

- (id)init
{
    self = [super init];
    //XXMARK 创建数据库
    _dataBaseQueue=[[FMDatabaseQueue alloc]initWithPath:[SqliteDataBase customerDataBasePath:DataBasePath]];
    _operationQueue = dispatch_queue_create("operationQueue", DISPATCH_QUEUE_SERIAL);
    return self;
}

+ (SqliteDataBase*)sharedSqliteDataBase
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

//升级数据库
/*
 做版本兼容的处理
 
 1.获取实体属性 list
 2.获取现在 表中的列的list
 3.判断是否相同
 4.如果不同，就增加列。现在sqlite不支持删除列，这里这里全部做增加处理
 备注：这个也是根据数据库的版本号来的
 */

- (void)upgradeDataBase
{
    typeof(self) __weak weakSelf = self;
    
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *resultSet = nil;
        
        resultSet = [db executeQuery:@"SELECT * FROM sqlite_master where type= 'table'"];
        
        NSMutableArray *tableNames = [NSMutableArray array];
        
        // 遍历查询结果，并获取所有的表名 list
        while (resultSet.next) {
            
            NSString *str1 = [resultSet stringForColumnIndex:1];
            [tableNames addObject:str1];
        }
        
        //获取当前表中的列名list
        NSMutableDictionary *globalResultDict = [NSMutableDictionary dictionary];
        
        for (NSString *tableName in tableNames) {
            
            FMResultSet *resultSet = nil;
            
            NSString *tmpString= [NSString stringWithFormat:@"PRAGMA table_info(%@)",tableName];
            
            resultSet = [db executeQuery:tmpString];
            
            NSMutableArray *tablePropertyNameList = [NSMutableArray new];
            
            while (resultSet.next) {
                
                NSString *propertyName = [resultSet stringForColumnIndex:1];
                
                [tablePropertyNameList addObject:propertyName];
                
                NSLog(@"%@",propertyName);
            }
            [globalResultDict setObject:tablePropertyNameList forKey:tableName];
        }
        //获取了一个字典，字典的key是表名字   value是表的列的数组
        [weakSelf uploadDataBaseResult:globalResultDict dataBase:db];
    }];
}

/// 多线程下 可能导致的崩溃  -XXMARK
/*
 这里可以得出结论，在 FMResultSet dealloc 时会调用 close 方法，来关闭预处理语句。再回到第一节的 crash 堆栈，不难发现线程7在用同一个数据库连接读数据库，结合官方文档中的一段话，我们就可以得出结论了。
 
 使用 FMDatabaseQueue 还是发生了多线程使用同一个数据库连接、预处理语句的情况，于是就崩溃了。

 FMDB的正确打开方式
 如果用 while 循环遍历 FMResultSet 就不存在该问题，因为 [FMResultSet next] 遍历到最后会调用 [FMResultSet close]。
 [_queue inDatabase:^(FMDatabase * _Nonnull db) {
     FMResultSet *result = [db executeQuery:@"select * from test where a = '1'"];
     // 安全
     while ([result next]) {
     }
     
     // 安全
     if ([result next]) {
     }
     [result close];
 }];

 如果一定要用 if ([result next]) ，手动加上 [FMResultSet close] 也没有问题。

 链接：https://juejin.im/post/5c4f25f8f265da612e29018f

 */
//- (void)testMultiThread{
//    NSString *dbPath = [dbPath stringByAppendingPathComponent:@"test.sqlite"];
//    _queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
//
//        // 构建测试数据，新建一个表test，inert一些数据
//        [_queue inDatabase:^(FMDatabase * _Nonnull db) {
//            [db executeUpdate:@"create table if not exists test (a text, b text, c text, d text, e text, f text, g text, h text, i text)"];
//            for (int i = 0; i < 10000; i++) {
//                [db executeUpdate:@"insert into test (a, b, c, d, e, f, g, h, i) values ('1', '1', '1','1', '1', '1','1', '1', '1')"];
//            }
//        }];
//
//        // 多线程查询数据库
//        for (int i = 0; i < 10; i++) {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                [_queue inDatabase:^(FMDatabase * _Nonnull db) {
//                    FMResultSet *result = [db executeQuery:@"select * from test where a = '1'"];
//                    // 这里要用if，改成while就没问题了
//                    if ([result next]) {
//                    }
//                    // 这里不调用close
//    //                [result close];
//                }];
//            });
//        }
//
//}


//这里做现在的属性和之前表结构的属性的一个对比，如果不同的话，就直接记录，并做增加列处理
- (void)uploadDataBaseResult:(NSDictionary*)resultDict dataBase:(FMDatabase*)db
{
    NSMutableDictionary *equalDict = [NSMutableDictionary new];
    
    NSArray *keyArray = resultDict.allKeys;
    
    for (NSString *keyString in keyArray) {
        
        NSString *itemClassName = [keyString substringWithRange:NSMakeRange(0, keyString.length-5)];
        
        NSArray *equal1Array =[NSClassFromString(itemClassName) requireProperties];
        NSArray *equal2Array = [resultDict objectForKey:keyString];
        
        NSMutableSet *set1 = [NSMutableSet setWithArray:equal1Array];
        NSMutableSet *set2 = [NSMutableSet setWithArray:equal2Array];
        
        // [set1 unionSet:set2];//取并集
        // [set1 intersectSet:set2];  //取交集
        // [set1 minusSet:set2];//取差集后   array1 与array2的差集
        [set1 minusSet:set2];//取差集后    array2 与array1的差集
        
        NSLog(@"set1-------》%@",set1);
        NSLog(@"set2-------》%@",set2);
        
        
        if (set1.count > 0) {
            
            NSLog(@"当前表有变动");
            
            NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
            NSArray *sortSetArray = [set1 sortedArrayUsingDescriptors:sortDesc];
            [equalDict setObject:sortSetArray forKey:keyString];
            
        }else{
            
            NSLog(@"当前表没有变动");
        }
    }
    NSLog(@"得到了比较后的数据  --->:%@",equalDict);
    
    [self uploadDataBase:db equalDict:equalDict];
    
}

- (void)uploadDataBase:(FMDatabase*)db equalDict:(NSMutableDictionary*)dict
{
    NSLog(@"%@",dict);
    
    NSArray *keyArray = dict.allKeys;
    
    for (NSString *tableName in keyArray) {
        
        NSString *itemClassName = [tableName substringWithRange:NSMakeRange(0, tableName.length-5)];
        
        NSArray *requiredArray =[NSClassFromString(itemClassName) requireProperties];
        
        NSArray *typeArray =[NSClassFromString(itemClassName) requerePropertyStringTypes];
        
        //这里做增加列的操作。
        NSArray *setArray = [dict objectForKey:tableName];
        
        for (NSString * value in setArray) {
            
            NSLog(@"2--->:%@",value);
            
            NSString *typeString = [typeArray objectAtIndex:[requiredArray indexOfObject:value]];
            
            NSObject *defaultValue= nil;
            
            if ([typeString isEqualToString:@"Text"]) {
                
                defaultValue= [NSString stringWithFormat:@"'%@'",@"N"];
                
            }else{
                
                defaultValue = @0;
            }
            
            NSString *addString= [NSString stringWithFormat:@"alter table %@ add column %@ %@ default %@",tableName,value,typeString,defaultValue];
            
            NSLog(@"%@",addString);
            
            [db executeUpdate:addString];
        }
        
    }
}



@end
