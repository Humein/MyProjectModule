//
//  CellModel.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CellFModel.h"

@implementation CellFModel
+ (instancetype)bodyWithDict:(NSDictionary *)dict
{
    CellFModel *body = [[CellFModel alloc] init];
    body.poi_name = dict[@"poi_name"];
    body.imageURL = dict[@"imageURL"];
    body.section_title = dict[@"section_title"];
    body.fav_count = dict[@"fav_count"];
    
    return body;
}
@end
