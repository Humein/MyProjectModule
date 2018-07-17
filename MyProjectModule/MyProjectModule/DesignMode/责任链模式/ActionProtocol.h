//
//  ActionProtocol.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

@protocol ActionProtocol <NSObject>

- (void)responseEvent:(NSInteger )eventType playItem:(id)playItem;

@end
