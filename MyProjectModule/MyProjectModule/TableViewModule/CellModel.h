//
//  cellModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//所有自己创建的对象都继承这个类，把原型模式加进来,以及归档等等

@interface CellModel : NSObject <NSCopying,NSMutableCopying,NSCoding>

@property (nonatomic,assign)CGFloat itemHeight;

@property (nonatomic,assign)CGFloat itemWidth;

@property (nonatomic,copy)NSString *title;

-(CGFloat)titleHeight;
@end
