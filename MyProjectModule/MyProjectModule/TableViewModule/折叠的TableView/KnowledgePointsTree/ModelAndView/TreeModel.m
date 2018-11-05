//
//  TreeModel.m
//  KnowledgeTree
//
//  Created by 鑫鑫 on 2017/4/12.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "TreeModel.h"
#import "MJExtension.h"
@implementation TreeModel
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"knowledgeID":@"id",@"childrenKnowledgeModelArray":@"children"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"childrenKnowledgeModelArray":@"TreeModel"};
}

+(TreeModel *)selectKnowledgeModelWithKnowledgeID:(NSString *)knowledgeid fromKnowledgeModelArray:(NSArray *)modelArray{
    for(TreeModel *obj in modelArray){
        if([obj.knowledgeID isEqualToString:knowledgeid]){
            return obj;
        }else{
            return [TreeModel selectKnowledgeModelWithKnowledgeID:knowledgeid fromKnowledgeModelArray:obj.childrenKnowledgeModelArray];
        }
    }
    return nil;
}

+(NSArray *)allChildNodeWithKnowledgeModel:(TreeModel *)model{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    for(TreeModel *obj in model.childrenKnowledgeModelArray){
        [mArray addObject:obj];
        [mArray addObjectsFromArray:[TreeModel allChildNodeWithKnowledgeModel:obj]];
    }
    return mArray;
}
-(id)initModelWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if(self){
        self = [[self class] objectWithKeyValues:dic];
    }
    return self;
}

@end
