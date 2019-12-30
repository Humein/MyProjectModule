//
//  ActionProtocol.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//


//播放中的各个事件的传递
enum{
    HTVideoPlayerBackEvent=100,         //返回
    HTVideoPlayEvent,                   //播放
    HTVideoStopEvent,                   //停止
    HTVideoPauseEvent,                  //暂停
    HTVideoLockEvent,                   //锁屏事件
    HTVideoUnLockEvent,                 //解锁屏事件
    HTVideoPlayerFullScreenEvent,       //大屏幕，手动点击
    HTVideoPlayerSmallScreenEvent,      //小屏幕，手动点击
    HTVideoPlayerAutoFullScreenEvent,   //屏幕自动旋转到大屏幕
    HTVideoPlayerAutoSmallScreenEvent,  //屏幕自动旋转到小屏幕
    
    HTVideoPlayerSeekTimeEvent,         //跳转到对应时间的事件
    HTVideoPlayerSendMessageEvent,      //发送消息事件
    HTVideoPlayerMessageComeInEvent,    //消息进来，这个是慢慢的进来的，需要做插入操作
    HTVideoPlayerReadMessageInEvent,    //读取到消息，这个时候需要把之前的消息一次清空，重新加载的操作,在跳转等地方获取
    HTVideoPlayerDeleteMessageEvent,    //删除聊天消息事件
    
    HTVideoPlayerChangeDefinitionEvent, //切换清晰度
    HTVideoPlayerChangeRateEvent,       //切换倍率
    HTVideoPlayerChangeLessionEvent,    //切换课程事件（暂时没用）
    HTVideoPlayerExchangeItemEvent,     //切换课程
    HTVideoPlayerExchangePPTEvent,      //切换ppt的事件
    HTVideoPlayerExchangeShuSpeedEvent, //弹切换竖屏倍速页面事件
    
    HTTapToHiddenEvent,                 //点击消失事件
    HTTapToShowEvent,                   //点击显示事件
    HTTapToShowTopEvent,                //点击显示头部区域
    HTTapToHiddenKeyboardEvent,         //点击隐藏键盘事件
    HTPlayStatusChangeEvent,            //播放的状态发生变化
    
    HTAlertSpeedRateViewEvent,          //弹切换速度框
    HTAlertMessageChatViewEvent,        //弹互动框
    HTAlertMoreViewEvent,               //弹更多按钮对应的框
    HTAlertLessionListViewEvent,        //弹课表的事件框
    HTAlertDefineEvent,                 //弹清晰度框
    HTAlertViewHiddenEvent,             //弹框消失事件
    HTVideoPlayerAlertCommentEvent,     //弹评论框事件
    
    HTVideoPlayerPlayProgressEvent,     //播放进度的事件
    HTVideoPlayerPlayEndEvent,          //播放完毕的事件
    HTVideoPlayerPlayErrorEvent,        //播放出错的事件
    
    HTVideoPlayerChangeChatAreaEvent,    //关闭聊天区
    
    HTSliderTimeEvent,                  //滑动进度的事件（目前未使用，不想使用了）
    HTGetIsOpenCameralStatusEvent,      //获取是否开启摄像头事件
    
    HTVideoPlayerExerciseEvent,         //进行课后习题事件
    HTVideoPlayerTapSuiTangLianEvent,   //点击了随堂练
    HTVideoPlayerAddTapSuiTangLianEvent,//添加点击随堂练手势（只有有才添加，减少冲突的发生）
    
    HTVideoPlayerDanMuOpenEvent,        //弹幕打开事件
    HTVideoPlayerDanMuCloseEvent,       //弹幕关闭事件
    HTVideoPlayerSendDanmuEvent,        //发送弹幕
    
    HTVideoPlayerShowLiveFunctionEvent,  //显示直播、直播回放功能区
    HTVideoPlayerHiddenLiveFunctionEvent,//隐藏直播、直播回放功能区
    
    HTVideoPlayerJumpTinyLiveEvent,         //跳转小班课事件
    HTVideoPlayerSlideOpenSmallVideoEvent,  //把小屏播放滑出来
    HTVideoPlayerSliderCloseSmallVideoEvent,//把小屏播放关闭
    HTVideoPlayerOnlineUserCountChangeEvent //直播在线人数改变
    
};
typedef NSInteger HTPlayItemEventType;

@protocol ActionProtocol <NSObject>

//绑定数据
- (void)attachPlayItem:(id )playItem;

//相应数据
- (void)responseEvent:(NSInteger )eventType playItem:(id )playItem;

//在什么条件下，事件不再往下传递
- (BOOL)isEventTransferForEventType:(NSInteger)eventType;

@end
