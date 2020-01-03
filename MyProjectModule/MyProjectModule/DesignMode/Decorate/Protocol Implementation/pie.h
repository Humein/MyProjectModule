//
//  pie.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hamburger.h"
@interface pie : NSObject<Decorator>
@property (nonatomic, strong, readonly) Hamburger *burger;

- (instancetype)initWithChickenBurger:(id<Decorator>)burger;
@end
