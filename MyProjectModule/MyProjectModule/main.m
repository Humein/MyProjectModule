//
//  main.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
typedef void(^MyBlock)(void);

@interface MyObject : NSObject
@property(nonatomic,copy) MyBlock block;
@end

@implementation MyObject
- (instancetype)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    NSLog(@"MyObject dealloc!");
}
@end
int main(int argc, char * argv[]) {

    @autoreleasepool {
        // Block 崩溃问题
        MyObject *myObject = [[MyObject alloc] init];
        __weak typeof(myObject) weakObject = myObject;
        __block MyObject *tempObject = myObject;
        myObject.block = ^{
            //Capturing 'myObject' strongly in this block is likely to lead to a retain cycle
            NSLog(@"捕获对象:%@", tempObject );
            tempObject = nil;  //关键代码1
        };
        tempObject.block(); //关键代码2：执行持有的block；
    }
    
    NSLog(@"myObject的作用域结束了");
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

}


