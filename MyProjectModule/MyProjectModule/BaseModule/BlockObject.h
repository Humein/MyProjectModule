//
//  BlockObject.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BlockObject : UIViewController

//As a property
@property (nonatomic,copy) void (^rightBarItemClickBlock)(UIButton *button, NSInteger index);
//返回值,链式编程实现原理
- (BlockObject * (^) (NSString * rightName,CGRect frame,BOOL isImage))rightBarItem;
@end
