//
//  PointTreeTypeThree.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompositePointTreeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PointTreeTypeThree : NSObject<ModelProtocol>
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

//点播使用字段
@property(nonatomic,copy) NSString *videoId;

@property(nonatomic,copy) NSString *videoLength;

@property(nonatomic,assign) NSInteger videoType;

@property(nonatomic,assign) NSInteger isFinish;

@property(nonatomic,assign) NSInteger isStudy;

@property(nonatomic,assign) NSInteger lastStudy;

@property(nonatomic,copy) NSString *joinCode;

@property(nonatomic,assign) NSInteger liveStatus;

@property(nonatomic,copy) NSString *studyPercent;

@property(nonatomic,assign) NSInteger studySchedule;


@property(nonatomic,assign) NSInteger inPage; //当前课件在横屏的位置

@property(nonatomic, assign) NSInteger liveStart; //距直播开始时间（秒）
@property(nonatomic, assign) NSTimeInterval liveStartTime; //直播开始时间戳
@property (nonatomic,copy)NSString *NetClassId;//大课ID
@property (nonatomic,copy)NSString *classId;//大课ID
@property (nonatomic,copy)NSString *bulletClassId;//横盘

@property (nonatomic,copy)NSString *positionLiveNode;


@property(nonatomic, assign) NSInteger tinyLive; //是否是小班课

@property(nonatomic, assign) NSInteger alreadyStudyTime;

@property (nonatomic, assign) BOOL isDownload;

@property (nonatomic, assign) BOOL isSelected;

@property(nonatomic, copy) NSString *sign;

//直播创建房间使用数据zt
@property (nonatomic, copy) NSString *userAvatar;//头像
@property (nonatomic, copy) NSString *userNick;//昵称
@property (nonatomic, copy) NSString *userNumber;


@end

NS_ASSUME_NONNULL_END
