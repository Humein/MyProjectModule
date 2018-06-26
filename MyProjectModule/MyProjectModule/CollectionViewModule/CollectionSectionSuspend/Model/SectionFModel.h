//
//  SectionModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionFModel : NSObject
@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *tag_name;

@property (nonatomic, copy) NSString *section_count;

@property (nonatomic, strong) NSArray *body;

+ (instancetype)homeWithDict:(NSDictionary *)dict;
@end
