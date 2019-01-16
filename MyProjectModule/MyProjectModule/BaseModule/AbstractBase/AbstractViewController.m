//
//  AbstractViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AbstractViewController.h"
#import "UIButton+Decorate.h"
#define Font(a) [UIFont systemFontOfSize:(a)]
#define HexColor(value,a)   [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0x00FF00) >> 8)/255.0 blue:(value & 0x0000FF)/255.0 alpha:(a)]

@interface AbstractViewController ()

@end

@implementation AbstractViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController.viewControllers.count >1) {
        self.leftBarItem(@"gl_view_control_back",CGRectMake(0, 0, 40, 40),YES);
    }
    
    typeof(self) __weak weakSelf = self;
    
    self.leftBarItemClickBlock = ^(UIButton *button, NSInteger index) {
        if (index==0) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
}


#pragma mark- 设置导航栏

- (UIButton*)buttonItemForIndex:(NSInteger)index isLeft:(BOOL)isLeft
{
    if (isLeft) {
        
        NSArray *array = self.navigationItem.leftBarButtonItems;
        UIBarButtonItem *barButtonItem = [array objectAtIndex:index];
        return barButtonItem.customView;
    }else{
        NSArray *array = self.navigationItem.rightBarButtonItems;
        NSInteger count = array.count;
        UIBarButtonItem *barButtonItem = [array objectAtIndex:count-1-index];
        return barButtonItem.customView;
    }
}

- (AbstractViewController * (^) (NSString * leftName,CGRect frame,BOOL isImage))leftBarItem
{
    typeof(self) __weak weakSelf = self;
    AbstractViewController * (^leftItemBlock) (NSString * leftName,CGRect frame,BOOL isImage)= ^(NSString * leftName,CGRect frame,BOOL isImage){
        
        UIBarButtonItem *barButtonItem = nil;
        if (isImage) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button sizeToFit];
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0); button.normalImageName(leftName).buttonFrame(frame).targetAction(weakSelf,@selector(leftButtonClick:));
            
            barButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
            
        }else{
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button sizeToFit];
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0); button.buttonText(leftName).buttonFrame(frame).targetAction(weakSelf,@selector(leftButtonClick:)).buttonFont(Font(15)).normalTitleColor([UIColor redColor]);
            barButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        }
        
        NSArray *array = self.navigationItem.leftBarButtonItems;
        
        NSMutableArray *mutableArray = [array mutableCopy];
        
        if (mutableArray == nil) {
            mutableArray = [NSMutableArray array];
        }
        [mutableArray addObject:barButtonItem];
        
        self.navigationItem.leftBarButtonItems= nil;
        
        self.navigationItem.leftBarButtonItems= mutableArray;
        
        return self;
    };
    
    return leftItemBlock;
}

- (AbstractViewController * (^) (NSString * rightName,CGRect frame,BOOL isImage))rightBarItem
{
    typeof(self) __weak weakSelf = self;
    AbstractViewController * (^rightItemBlock) (NSString * rightName,CGRect frame,BOOL isImage)= ^(NSString * rightName,CGRect frame,BOOL isImage){
        
        UIBarButtonItem *barButtonItem = nil;
        
        if (isImage) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button sizeToFit];
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20); button.normalImageName(rightName).buttonFrame(frame).targetAction(weakSelf,@selector(rightButtonClick:));
            barButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
            
        }else{
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button sizeToFit];
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20); button.buttonText(rightName).buttonFont(Font(15)).normalTitleColor(HexColor(0x666666, 1)).buttonFrame(frame).targetAction(weakSelf,@selector(rightButtonClick:));
            barButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        }
        
        NSArray *array = self.navigationItem.rightBarButtonItems;
        
        NSMutableArray *mutableArray = [array mutableCopy];
        
        if (mutableArray == nil) {
            mutableArray = [NSMutableArray array];
        }
        
        [mutableArray insertObject:barButtonItem atIndex:0];
        
        self.navigationItem.rightBarButtonItems= nil;
        
        self.navigationItem.rightBarButtonItems= mutableArray;
        
        return self;
    };
    
    return rightItemBlock;
}

- (void)setLeftBarItemClickBlock:(void (^)(UIButton *, NSInteger))leftBarItemClickBlock
{
    leftBarItemClickBlock ? _leftBarItemClickBlock= [leftBarItemClickBlock copy] :nil;
}

- (void)setRightBarItemClickBlock:(void (^)(UIButton *, NSInteger))rightBarItemClickBlock
{
    rightBarItemClickBlock ? _rightBarItemClickBlock = [rightBarItemClickBlock copy] :nil;
}



- (void)leftButtonClick:(UIButton*)leftButton
{
    int index= 0;
    for (UIBarButtonItem *buttonItem in self.navigationItem.leftBarButtonItems) {
        
        if (buttonItem.customView == leftButton) {
            break;
        }
        index++;
    }
    self.leftBarItemClickBlock ? self.leftBarItemClickBlock (leftButton,index) : nil;
}

- (void)rightButtonClick:(UIButton*)rightButton
{
    int index= 0;
    
    for (UIBarButtonItem *buttonItem in self.navigationItem.rightBarButtonItems) {
        
        if (buttonItem.customView == rightButton) {
            break;
        }
        index++;
    }
    self.rightBarItemClickBlock ? self.rightBarItemClickBlock (rightButton,index) : nil;
}

-(void)simulateTime_consumingOperation:(ResultStatus)status{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 30; i++) {
            NSLog(@"%@",@"");
        }
        status(YES);
    });
                   

}
@end
