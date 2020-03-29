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



- (void)requestNoticeDataWithParameter:(NSDictionary *)dic isWaiting:(BOOL)isWaiting success:(Success)success failure:(Failure)failure{
    
    if (success) {
        success(@"");
    }
    
    if (failure) {
        failure(@"");
    }
    
}

- (void)jumpConfig:(IDBlock )configBlock completeBlock:(MiniProgramResultBlock)completeBlock{

    // 正传

//    __block HTMiniProgramModel *configItem = [[HTMiniProgramModel alloc] init];
    
//    if (configBlock)
//    {
//        configBlock(configItem);
//    }
//    _configItem = configItem;
//
    
    // useage
    /*
     [vc pushWithConfigModel:^(NSMutableArray<ParaModel *> * _Nullable paramArray) {
     ParaModel *videoModel = [ParaModel new];
     videoModel.title = VideoCache;
     videoModel.classId = weakSelf.classId;
     videoModel.classUrl = weakSelf.scheduleModel.scaleimg;
     videoModel.className = weakSelf.scheduleModel.title;
     videoModel.coursewareHours = weakSelf.scheduleModel.coursewareHours;
     ParaModel *PDFModel = [ParaModel new];
     PDFModel.title = PDFCache;
     [paramArray addObject:videoModel];
     [paramArray addObject:PDFModel];
     } completeBlock:^(BOOL isCanPush) {
     if (isCanPush && weakSelf.isDone) {
     [weakSelf.navigationController pushViewController:vc animated:YES];
     }else{
     [weakSelf showInfoText:@"该课程暂时没有视频可以缓存" type:InfoNone];
     }
     }]
     */
    
    
    
    
    //逆传
    _completeBlock = completeBlock;
    if (YES)
    {
        _completeBlock ? _completeBlock(YES) : nil;
        return;
    }
    
    
}


// Masonry中正是使用了 函数式编程与链式编程 的方式
/// 返回值 是个有返回值的匿名有参block 
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
        
//         通过 函数式编程和链式编程 将barButtonItem 一一添加到数组里面（装饰者？？？）
        [mutableArray insertObject:barButtonItem atIndex:0];
        
        self.navigationItem.rightBarButtonItems= nil;
        
        self.navigationItem.rightBarButtonItems= mutableArray;
        
        return self;
    };
    
    return rightItemBlock;
}




#pragma mark -- 链式编程
- (BlockObject *)run2{
    NSLog(@"跑肚");
    return self;
}
- (BlockObject *)eat2{
    NSLog(@"吃东西");
    return self;
}

#pragma mark -- 函数式编程 1
/// 返回值  是个无返回值的匿名block
- (void (^)(void))run3{
    // 创建一个block
    void(^MyBlock)(void) = ^{
        NSLog(@"跑步3");
    };
    return MyBlock;
}

- (void (^)(void))eat3{
    
    // 在run3的基础上,将block的定义和返回合并
    return ^{
        NSLog(@"吃饭3");
    };
}

#pragma mark -- 函数式编程 2
/// 返回值 是个有返回值的匿名block
- (BlockObject * (^)(void))run4{
    // 创建 返回值是self的block
    BlockObject * (^MyBlock)(void) = ^{
        NSLog(@"跑步4");
        return self;
    };
    
    return MyBlock;
}

- (BlockObject * (^)(void))eat4{
    return ^{
        NSLog(@"吃饭4");
        return self;
    };
}

#pragma mark -- 函数式编程 3
///  返回值 是个有返回值的匿名有参block
- (BlockObject *(^)(double))run5{
    return ^(double distance){
        NSLog(@"跑了%.2f米",distance);
        return self;
    };
}
- (BlockObject *(^)(NSString *))eat5{
    return ^(NSString *kindOfFood){
        NSLog(@"吃了%@",kindOfFood);
        return self;
    };
}

-(void)activeEventBlock:(void(^)(BOOL state))block{
    
}

@end
