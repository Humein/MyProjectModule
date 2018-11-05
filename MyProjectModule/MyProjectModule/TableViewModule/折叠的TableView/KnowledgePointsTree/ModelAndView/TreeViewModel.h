//
//  TreeViewModel.h
//  KnowledgeTree
//
//  Created by 鑫鑫 on 2017/4/12.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeModel.h"
typedef NS_ENUM(NSInteger, ErrorQuestionCellLevel) {
    ErrorQuestionCellLevelOne = 0,
    ErrorQuestionCellLevelTwo ,
    ErrorQuestionCellLevelThree ,
};

typedef NS_ENUM(NSInteger, ErrorQuestionCellIndex) {
    ErrorQuestionCellIndexTop = 1,
    ErrorQuestionCellIndexCenter,
    ErrorQuestionCellIndexBottom,
};

typedef NS_ENUM(NSInteger, ErrorQuestionCellOpenState) {
    ErrorQuestionCellOpen = 1,
    ErrorQuestionCellClose,
};
@interface TreeViewModel : NSObject
@property(nonatomic,strong) TreeModel *knowledgeModel;
@property(nonatomic,assign) ErrorQuestionCellLevel level;
@property(nonatomic,assign) ErrorQuestionCellIndex index;
@property(nonatomic,assign) ErrorQuestionCellOpenState openstate;
@end
