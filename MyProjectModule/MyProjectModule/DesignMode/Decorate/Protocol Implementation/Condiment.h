//
//  Condiment.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pie.h"
@interface Condiment : NSObject<Decorator>

@property (nonatomic, strong, readonly) pie *pieCa;

- (instancetype)initWithChickenBurger:(id<Decorator>)pieCa;


@end
