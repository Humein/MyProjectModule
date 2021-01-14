//
//  ClassClusterTableViewCellB.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ClassClusterBaseTableViewCell.h"
#import "MultiCellProtocol.h"
NS_ASSUME_NONNULL_BEGIN

// !!!: 配置代理回掉
@protocol ViewControllerBDelegate<NSObject>
//代理方必须实现的方法
@required
- (void)viewControllersendValue:(NSString *)value;
//代理方可选实现的方法
@optional
- (void)viewControllerBsendValue:(NSString *)value;
@end

@interface ClassClusterTableViewCellB : ClassClusterBaseTableViewCell<MultiCellConfigPropotol>

//委托代理人，为了避免造成循环引用，代理一般需使用弱引用
@property(weak,nonatomic) id<ViewControllerBDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
