//
//  RAC_View.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/17.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "RAC_View.h"
#import "RAC_ViewModel.h"
@interface RAC_View()
@property (nonatomic, strong) RAC_ViewModel *viewModel;
@end

@implementation RAC_View

#pragma mark -
#pragma mark - life cycle - 生命周期
- (void)dealloc{
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)bindUserSeatViewModel:(RAC_ViewModel *)viewModel {
    self.viewModel = viewModel;
    // 信号传递
//    [self.tutorSeatView bindTecSeatViewModel:viewModel.tecSeatViewModel];
    /// 添加相关信号
//    [self addSignal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 改变信号
    [self.viewModel.pageSelectSubject sendNext:touches];
}

- (void)addSignal {
//    @weakify(self);
//    /// 切换了导航type
//    [RACObserve(self.viewModel, seatShowType) subscribeNext:^(id x) {
//        @strongify(self);
//        [self updateUserSeatSubViewConstraintsBySeatShowType];
//    }];
//    /// 获取到直播云相关参数信息，创建房间，推流
//    [[RACObserve(self.viewModel, roomRtcInitModel) skip:1] subscribeNext:^(id x) {
//        @strongify(self);
//        [self.viewModel  creatSeatLiveRoomTeacherView:self.tutorSeatView studentSeatViews:self.studentSeatViewArray];
//    }];
//    /// 获取到学生数据之后，将学生做展示
//    [RACObserve(self.viewModel, studentSeatVMListData) subscribeNext:^(id x) {
//        @strongify(self);
//        [self createStudentSeatWithPageIndex];
//        NSLog(@"%@",self.viewModel.studentSeatVMListData);
//    }];
//    /// 点击了辅导老师头像
//    [self.viewModel.clickTutorSeatViewSubject subscribeNext:^(id x) {
//
//    }];
}

#pragma mark -
#pragma mark - init setup - 初始化视图
- (void)setup{
    [self setDefault];//初始化默认数据
    [self setupSubViews];//设置子View
    [self setupSubViewsConstraints];//设置子View约束
}

/// 设置默认数据
- (void)setDefault{
    
}

/// 设置子视图
- (void)setupSubViews{
    
}

/// 设置子视图约束
-(void)setupSubViewsConstraints{
    
}

#pragma mark -
#pragma mark - public methods


#pragma mark -
#pragma mark - <#custom#> Delegate

#pragma mark -
#pragma mark - event response

#pragma mark -
#pragma mark - private methods

#pragma mark -
#pragma mark - getters and setters

@end
