//
//  ResponOfChainManager.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionProtocol.h"
@interface ResponOfChainManager : NSObject<ActionProtocol>

@property (nonatomic, strong) id<ActionProtocol> superior;


@end
