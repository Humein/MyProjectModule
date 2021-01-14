//
//  MultiCellProtocol.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/4/8.
//  Copyright © 2019 xinxin. All rights reserved.
//

@class ClassClusterModel;

@protocol MultiCellConfigPropotol <NSObject>
// !!!:  定义代理事件,  代替cell block方式的事件回调。避免cell类型判断。
- (void)configEventDelegate:(id)delegate;
// !!!:  定义不同Cell类型协议接口, 避免cell的if-else方式配置model
- (void)configCellWithModel:(ClassClusterModel *)model;

@end
