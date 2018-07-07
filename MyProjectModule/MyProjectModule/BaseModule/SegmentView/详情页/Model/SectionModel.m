//
//  sectionModel.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel
-(instancetype )initWithPushControllerClassString:(NSString *)pushControllerClassString titleImage:(NSString *)titleImage title:(NSString *)title arrowImage:(NSString *)arrowImage{
    self = [super init];
    if(self){
        self.pushControllerClassString = pushControllerClassString;
        self.title = title;
        self.titleImage = titleImage;
        self.arrowImage = arrowImage;
        
    }
    return self;
    
}
@end
