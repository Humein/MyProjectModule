//
//  AbstractViewController.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_H SCREEN_BOUNDS.size.height
#define SCREEN_W SCREEN_BOUNDS.size.width


typedef enum : NSUInteger {
    RealType = 100,
    SimulateType ,
} ExamPaperType;


// 结构体
typedef struct{
    ExamPaperType examType;
    NSNumber *ordDetailId;
    NSNumber *subjectId;
    NSNumber *paperCode;
    NSNumber *recordId;
    
} RequestParam;


typedef void(^ResultStatus)(BOOL suc);

@interface AbstractViewController : UIViewController
//左边按钮，点击回调
@property (nonatomic,copy) void (^leftBarItemClickBlock)(UIButton *button, NSInteger index);

//右边按钮，点击回调
@property (nonatomic,copy) void (^rightBarItemClickBlock)(UIButton *button, NSInteger index);

//从左到右排
- (AbstractViewController * (^) (NSString * leftName,CGRect frame,BOOL isImage))leftBarItem;

//从左到右排列
- (AbstractViewController * (^) (NSString * rightName,CGRect frame,BOOL isImage))rightBarItem;

-(void)simulateTime_consumingOperation:(ResultStatus)status;

@end
