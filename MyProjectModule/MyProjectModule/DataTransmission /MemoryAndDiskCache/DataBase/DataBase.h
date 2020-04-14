//
//  DataBase.h
//  DBProject
//
//  Created by Zhang Xin Xin on 2019/3/27.
//  Copyright © 2019 sunlands. All rights reserved.
//


#ifndef DataBase_h
#define DataBase_h


/*

 1.0版本
 
    1.常规操作
        1.1.常规操作就是增删改查，insert，delete，update，select
        1.2 事务操作，事务操作不能包括删表和建表
 
    2.数据库的本地升级
        2.1 对于任何一个模型数据表，这里就是依赖增加表列来做处理
 
    3.触发器
        3.1 增加表与表之间的触发动作
 
 2.0版本
 
    4.对象与对象之间的关系表，就是支持对象型
 
 */

#import "DBAbstractItem.h"

#import "SqliteDataBase.h"

#import "DataBaseManager.h"

#import "DBAbstractItem+DataBase.h"

#endif /* DataBase_h */
