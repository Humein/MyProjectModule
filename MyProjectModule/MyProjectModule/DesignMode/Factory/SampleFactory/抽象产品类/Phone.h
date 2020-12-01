//
//  Phone.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/26.
//  Copyright © 2020 xinxin. All rights reserved.
//
/*===================================================
        * 文件描述 ：抽象产品类 - 用到了模版模式 *
=====================================================*/
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, FactoryProductType){
    ProductTypeGetClassInfo, //了解班型信息
    ProductTypeTakeClassTest, //参加入学测试
    ProductTypeClassFitInfo, //适合班级信息
};
typedef void(^TouchesEvent)(FactoryProductType type);
@interface Phone : NSObject
/// ！！！父类定义接口和初始化 接口
- (void)packaging;
/// 配置视图信息
-(void)confingNoticeMessage:(id)model;
/// 事件回调
@property (nonatomic, copy) TouchesEvent block;
/// 背景视图
@property (nonatomic, strong) UIView *headerBackgroundView;
/// 提醒图片
@property (nonatomic, strong) UIImageView *noticeImageView;
/// 分割线
@property (nonatomic, strong) UIView *lineView;
/// 指向
@property (nonatomic, strong) UIButton *noticeDirect;
@end

NS_ASSUME_NONNULL_END
