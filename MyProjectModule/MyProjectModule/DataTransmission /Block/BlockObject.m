//
//  BlockObject.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#define Font(a) [UIFont systemFontOfSize:(a)]
#define HexColor(value,a)   [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0x00FF00) >> 8)/255.0 blue:(value & 0x0000FF)/255.0 alpha:(a)]

#import "BlockObject.h"
#import "UIControlFactory.h"
#import "UIButton+Decorate.h"

@interface BlockObject()

@property (nonatomic, copy) MiniProgramResultBlock completeBlock;

@end

@implementation BlockObject

// <1> x属性
- (BlockObject * (^) (NSString * rightName,CGRect frame,BOOL isImage))rightBarItem
{
    BlockObject * (^rightItemBlock) (NSString * rightName,CGRect frame,BOOL isImage)= ^(NSString * rightName,CGRect frame,BOOL isImage){
        
        UIBarButtonItem *barButtonItem = nil;
        
        if (isImage) {
            UIButton *button = [UIControlFactory button];
            [button sizeToFit];
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20); button.normalImageName(rightName).buttonFrame(frame).targetAction(self,@selector(rightButtonClick:));
            barButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
            
        }else{
            
            UIButton *button = [UIControlFactory button];
            [button sizeToFit];
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20); button.buttonText(rightName).buttonFont(Font(15)).normalTitleColor(HexColor(0x666666, 1)).buttonFrame(frame).targetAction(self,@selector(rightButtonClick:));
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


//<2>
 //网络请求
- (void)requestNoticeDataWithParameter:(NSDictionary *)dic isWaiting:(BOOL)isWaiting success:(Success)success failure:(Failure)failure{
    
    if (success) {
        success(@"");
    }
    
    if (failure) {
        failure(@"");
    }
    
}

- (void)jumpConfig:(modelBlock)configBlock completeBlock:(MiniProgramResultBlock)completeBlock{

    // 正传
//    __block HTMiniProgramModel *configItem = [[HTMiniProgramModel alloc] init];
//    if (configBlock)
//    {
//        configBlock(configItem);
//    }
//    _configItem = configItem;
//
    //逆传
    _completeBlock = completeBlock;
    if (YES)
    {
        _completeBlock ? _completeBlock(YES) : nil;
        return;
    }
    
    
}
@end
