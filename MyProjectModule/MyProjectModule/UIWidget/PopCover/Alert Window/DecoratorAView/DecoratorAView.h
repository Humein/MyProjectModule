//
//  DecoratorAView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopTableView.h"
@interface DecoratorAView : UIView <DecoratorProtocols>

@property (nonatomic, strong, readonly) PopTableView *burger;

- (instancetype)initWithChickenBurger:(id<DecoratorProtocols>)burger;


@end
