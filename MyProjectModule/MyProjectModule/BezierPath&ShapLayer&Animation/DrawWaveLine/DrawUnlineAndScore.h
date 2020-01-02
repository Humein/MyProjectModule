//
//  DrawUnlineAndScore.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/14.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 文字画波浪线
@interface DrawUnlineAndScore : NSObject
/**
 parm must be correct

 @param parm
           @"range":[NSValue valueWithRange:range0]?:@"",
           @"color":[UIColor redColor]?:@"",
           @"score":@"10",
 @param textView needDrawView
 */
- (void)drawUnlineWithParm:(NSDictionary *)parm withTheView:(UITextView *)textView;

@end
