//
//  ZTKBJDownHelper.h
//  NetRequstAPI_Example
//
//  Created by 鑫鑫 on 2018/5/10.
//  Copyright © 2018年 shou1wang@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTKDownHelperProtocol.h"
#import "ZTKDownItem.h"
@interface ZTKBJDownHelper : NSObject<ZTKDownHelperProtocol>
- (id)initWithDownItem:(ZTKDownItem *)downItem;

@end
