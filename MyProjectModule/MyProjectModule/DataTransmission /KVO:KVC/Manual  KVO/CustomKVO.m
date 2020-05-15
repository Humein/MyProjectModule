//
//  CustomKVO.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/14.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CustomKVO.h"
#import "PersonInfo.h"
#import "AppDelegate+DownManagerHelper.h"

@interface CustomKVO()
{
    PersonInfo *_myKVO;
    AppDelegate *_myName;
}
@end;
@implementation CustomKVO


-(void)viewDidLoad{
    _myKVO = [PersonInfo new];
    _myName = [AppDelegate new];
    [self addObserver];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [_myKVO setValue:@"nihao" forKey:@"name"];
    [_myName setValue:@"nihao" forKey:@"appName"];


}



#pragma mark ----- KVO

-(void)addObserver{
    //第一个参数observer：观察者 （这里观察self.myKVO对象的属性变化）
    
    //第二个参数keyPath： 被观察的属性名称(这里观察self.myKVO中num属性值的改变)
    
    //第三个参数options： 观察属性的新值、旧值等的一些配置（枚举值，可以根据需要设置，例如这里可以使用两项）
    
    //第四个参数context： 上下文，可以为kvo的回调方法传值（例如设定为一个放置数据的字典）
    
    //注册观察者
    
//    [_myKVO addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [_myName addObserver:self forKeyPath:@"appName" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}


//keyPath:属性名称

//object:被观察的对象

//change:变化前后的值都存储在change字典中

//context:注册观察者时，context传过来的值

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
//    NSLog(@"%@", change);
    if ([keyPath isEqualToString:@"name"])
    {
        //通知事件的处理
        NSLog(@"%@的名字发生了变化！%@", object, change);
    }
    
    
}





-(void)dealloc{
    
    [_myKVO removeObserver:self forKeyPath:@"name"];

}

@end
