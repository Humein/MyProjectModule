//
//  PhoneFactory.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/26.
//  Copyright © 2020 xinxin. All rights reserved.
//
/*===================================================
        * 文件描述 ：工厂类 - 简单工厂模式  *
=====================================================*/
#import <Foundation/Foundation.h>
#import "Phone.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhoneFactory : NSObject
/// ！！！工厂类 对外暴露API
// 工厂类向外部（客户端）提供了一个创造手机的接口createPhoneWithTag:，根据传入参数的不同可以返回不同的具体产品类。因此客户端只需要知道它所需要的产品所对应的参数即可获得对应的产品了。

+ (Phone *)createPhoneWithTag:(FactoryProductType)type;
@end

NS_ASSUME_NONNULL_END
