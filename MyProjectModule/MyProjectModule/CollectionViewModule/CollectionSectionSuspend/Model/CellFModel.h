//
//  CellModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellFModel : NSObject

@property (nonatomic, copy) NSString *section_title;

@property (nonatomic, copy) NSString *imageURL;

@property (nonatomic, copy) NSString *fav_count;

@property (nonatomic, copy) NSString *poi_name;

+ (instancetype)bodyWithDict:(NSDictionary *)dict;
@end
