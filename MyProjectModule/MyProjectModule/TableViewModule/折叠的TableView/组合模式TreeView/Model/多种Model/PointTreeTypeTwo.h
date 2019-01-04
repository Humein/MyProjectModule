//
//  PointTreeTypeTwo.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompositePointTreeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PointTreeTypeTwo : NSObject<ModelProtocol>
@property(nonatomic,assign) BOOL isExpansion;//是否展开

@property (nonatomic,assign) NSInteger afterCoreseNum;

@property(nonatomic,copy) NSString *bjyRoomId;

@property(nonatomic,copy) NSString *bjySessionId;

@property(nonatomic,assign) NSInteger classHour;//课时

@property(nonatomic,assign) NSInteger parentId;

@property(nonatomic,assign) NSInteger coursewareId;

@property(nonatomic,copy) NSString *fileSize;

@property(nonatomic,assign) NSInteger hasChildren;//是否有子节点

@property(nonatomic,assign) NSInteger ID;//大纲id

@property(nonatomic,assign) NSInteger isTrial;

@property(nonatomic,assign) NSInteger serialNumber;

@property(nonatomic,copy) NSString *studyLength;

@property(nonatomic,copy) NSString *teacher;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *token;

@property(nonatomic,assign) NSInteger type;

@property(nonatomic,copy) NSString *videoId;

@property(nonatomic,copy) NSString *videoLength;

@property(nonatomic,assign) NSInteger videoType;

@property(nonatomic,assign) NSInteger isFinish;

@property(nonatomic,assign) NSInteger isStudy;

@property(nonatomic,copy) NSString *joinCode;

@property(nonatomic,assign) NSInteger liveStatus;

@property(nonatomic,copy) NSString *studyPercent;

@property(nonatomic,assign) NSInteger studySchedule;

@property (nonatomic,strong) NSMutableArray * courseWareArray;

@property (nonatomic,strong) NSMutableArray * DeleteArray;

@end

NS_ASSUME_NONNULL_END
