//
//  UIImage+Title.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIImage+Title.h"
#import <objc/runtime.h>
static char titleKey;

@implementation UIImage (Title)

- (void)test{
//    self.titles = @"";
//    _titles
}

- (NSString *)title
{
    return objc_getAssociatedObject(self, &titleKey);
}

- (void)setTitle:(NSString *)title
{
    objc_setAssociatedObject(self, &titleKey, title, OBJC_ASSOCIATION_COPY);
}
@end
