//
//  sectionModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject
@property(nonatomic,strong) NSString *pushControllerClassString;
@property(nonatomic,strong) NSString *titleImage;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *arrowImage;
-(instancetype )initWithPushControllerClassString:(NSString *)pushControllerClassString titleImage:(NSString *)titleImage title:(NSString *)title arrowImage:(NSString *)arrowImage;

@end
