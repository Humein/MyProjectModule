//
//  ZTKDownHelperProtocol.h
//  NetRequstAPI_Example
//
//  Created by 鑫鑫 on 2018/5/10.
//  Copyright © 2018年 shou1wang@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//DownHelperProtocol
@protocol ZTKDownHelperProtocol <NSObject>

- (void)down;

- (void)stop;

- (void)resume;

- (void)deleteItem;

-(NSArray *)performQuery:(NSString *)query;
@end
