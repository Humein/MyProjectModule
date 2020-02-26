//
//  TreeModel.h
//  KnowledgeTree
//
//  Created by 鑫鑫 on 2017/4/12.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeModel : NSObject
@property(nonatomic,copy) NSString *knowledgeID;                        //知识点ID
@property(nonatomic,copy) NSString *name;                               //知识点名称
@property(nonatomic,copy) NSString *parent;                             //父节点
@property(nonatomic,copy) NSString *qnum;                               //试题数
@property(nonatomic,copy) NSString *rnum;                               //答对题数
@property(nonatomic,copy) NSString *wnum;                               //答错题数
@property(nonatomic,copy) NSString *unum;                               //未做题数
@property(nonatomic,copy) NSString *times;                              //做题总花费时间
@property(nonatomic,copy) NSString *speed;                              //做题平均时间
@property(nonatomic,copy) NSString *level;                              //节点级别
@property(nonatomic,copy) NSString *accuracy;                           //正确率
@property(nonatomic,strong) NSMutableArray *childrenKnowledgeModelArray;       //子节点

+(TreeModel *)selectKnowledgeModelWithKnowledgeID:(NSString *)knowledgeid fromKnowledgeModelArray:(NSArray *)modelArray;

+(NSArray *)allChildNodeWithKnowledgeModel:(TreeModel *)model;

-(id)initModelWithDictionary:(NSDictionary *)dic;

@end
