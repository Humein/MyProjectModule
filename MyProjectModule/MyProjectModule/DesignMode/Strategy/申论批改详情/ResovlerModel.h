//
//  ResovlerModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorrectTagModel.h"
@interface ResovlerModel : NSObject
/** 展示的内容 */
@property (nonatomic, strong) NSString *contentStr;
/** 波浪线后面的分数 */
@property (nonatomic, strong) NSString *scoreStr;
/** 一句话所有的Tag标签 */
@property (nonatomic, strong) NSArray <CorrectTagModel *>*tags;
/** 是否有下滑线 */
@property (nonatomic, assign) BOOL hasUnderWave;
/** 句子的范围 */
@property (nonatomic, assign) NSRange range;
/** 在带标签的段落中的位置 */
@property (nonatomic, assign) NSRange haveTagRange;
@end
