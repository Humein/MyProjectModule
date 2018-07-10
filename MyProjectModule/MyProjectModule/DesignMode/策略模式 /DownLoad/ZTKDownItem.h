//
//  ZTKDownItem.h
//  NetRequstAPI_Example
//
//  Created by 鑫鑫 on 2018/5/10.
//  Copyright © 2018年 shou1wang@gmail.com. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    
    BjyDownItemType=1,    //百家云的下载类型
    ZsDownItemType,     //展示的下载类型
    CCDownItemType      //cc的下载类型
    
} HtDownItemType;

@class ZTKDownItem;

//所有需要下载的模型都要实现这个转化的方法

@protocol HTDownItemProtocol <NSObject>

- (ZTKDownItem *)parseToDownItem;

@end

@interface ZTKDownItem : NSObject
@property (nonatomic,assign)HtDownItemType itemType;//下载的类型

@end
