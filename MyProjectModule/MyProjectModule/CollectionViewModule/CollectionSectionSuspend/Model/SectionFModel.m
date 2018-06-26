//
//  SectionModel.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SectionFModel.h"
#import "CellFModel.h"
@implementation SectionFModel
+ (instancetype)homeWithDict:(NSDictionary *)dict
{
    SectionFModel *home = [[SectionFModel alloc] init];
    home.tag_name = dict[@"tag_name"];
    home.section_count  = dict[@"section_count"];
    home.color = dict[@"color"];
    
    //字典数组转模型
    //保存模型的临时数组
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dictArray in dict[@"body"]) {
        CellFModel *body = [CellFModel bodyWithDict:dictArray];
        [temp addObject:body];
    }
    home.body = temp;
    
    return home;
    
}
@end
