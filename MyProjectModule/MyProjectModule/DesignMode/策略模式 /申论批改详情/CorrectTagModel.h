//
//  CorrectTagModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SLCorrectTagTypeJianHao,
    SLCorrectTagTypeZhongHao
} SLCorrectTagType;

@interface CorrectTagModel : NSObject
/** 单个Tag的分数 */
@property (nonatomic, assign) CGFloat score;
/** 内容 */
@property (nonatomic, strong) NSAttributedString *content;
/** 二级标签内容 */
@property (nonatomic, strong) NSString *subContent;
/** 再一句话中的位置 */
@property (nonatomic, assign) NSRange range;
/** 标签的类型 */
@property (nonatomic, assign) SLCorrectTagType tagType;
@end
