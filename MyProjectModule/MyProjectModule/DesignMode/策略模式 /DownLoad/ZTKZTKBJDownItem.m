//
//  ZTKZTKBJDownItem.m
//  NetRequstAPI_Example
//
//  Created by 鑫鑫 on 2018/5/12.
//  Copyright © 2018年 shou1wang@gmail.com. All rights reserved.
//

#import "ZTKZTKBJDownItem.h"


@implementation ZTKZTKBJDownItem

- (ZTKDownItem *)parseToDownItem {
    ZTKDownItem *tmpItem= [ZTKDownItem new];
    tmpItem.itemType = _itemType;
    return tmpItem;
}

@end
