//
//  CorrectResolver.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResovlerModel;

@interface CorrectResolver : NSObject
- (NSArray <ResovlerModel *>*)getSentenceItemsWithString:(NSString *)string;

@end
