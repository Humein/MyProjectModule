//
//  ResponOfChainManager.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "ResponOfChainManager.h"

@implementation ResponOfChainManager

#pragma mark - 打印所有节点
- (void)logAllNextNode
{
    NSLog(@"本身-->:%@",NSStringFromClass(self.class));
    NSLog(@"本身的头节点-->:%@",self.headerNodeView);
    NSLog(@"本身的前节点-->:%@ ",self.proNodeView);
    NSLog(@"本身的下一个节点-->:%@",self.nextNodeView);
    
    ResponOfChainManager *nextNodeView = self.nextNodeView;
    
    int index = 1;
    
    while (nextNodeView) {
        
        NSLog(@"第 %i个节点",index);
        
        NSLog(@"当前节点-->:%@",NSStringFromClass(nextNodeView.class));
        NSLog(@"当前节点的头节点-->:%@",nextNodeView.headerNodeView);
        NSLog(@"当前节点的前节点-->:%@ ",nextNodeView.proNodeView);
        NSLog(@"当前节点的下一个节点-->:%@",nextNodeView.nextNodeView);
        
        nextNodeView = nextNodeView.nextNodeView;
        
        index ++;
    }
    
}

- (void)dealloc
{
    NSLog(@"%@释放了---地址-->%p",[self class],self);
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}


#pragma mark - 绑定数据
- (void)attachPlayItem:(id )playItem{
//    初始化下一节点 需要的对象 (UIResponder ???)
      self.nextNodeView ? [self.nextNodeView attachPlayItem:playItem] : nil;
}

#pragma mark - 发送事件
- (void)requestEvent:(HTPlayItemEventType)eventType playItem:(id )playItem
{
    ResponOfChainManager *nodeView = self;
    //  找到头节点
    while (nodeView) {
        if (nodeView.proNodeView == nil) {
            // 找到后跳出循环
            break;
        }
        nodeView= nodeView.proNodeView;
    }
    // 从头节点开始 相应事件
    [nodeView responseEvent:eventType playItem:playItem];
}

#pragma mark - 响应事件
- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
    self.nextNodeView ? [self.nextNodeView responseEvent:eventType playItem:playItem] : nil;
    
    if ([self isEventTransferForEventType:eventType]==NO) {
        return;
    }
}

// 对哪些事件不做响应，可以不实现
- (BOOL)isEventTransferForEventType:(NSInteger)eventType
{
    return YES;
}

#pragma mark - 链表
//解绑，就是把自己给干掉
- (void)disattachPlayView
{
    self.proNodeView.nextNodeView= self.nextNodeView;
    
    self.nextNodeView.proNodeView= self.proNodeView;
    
    self.nextNodeView.headerNodeView= self.proNodeView.headerNodeView;
    
    self.proNodeView= nil;
    
    self.headerNodeView= nil;
    
    self.nextNodeView= nil;
    
    [self removeFromSuperview];
}

//设置next节点，默认在最后一个位置插入，链式操作，比较方便 Block（链式编程+函数式编程） 实现 链表  （Masonry中正是使用了函数式编程与链式编程的方式）

// -- 函数式编程步骤3 --> 传递参数
//函数式编程和链式编程
//- (BlockObject * (^)(double distance))run5;
//- (BlockObject * (^)(NSString *kindOfFood))eat5;

- (ResponOfChainManager * (^)(ResponOfChainManager* nextView))nextView{
    
    ResponOfChainManager *(^playViewBlock)(ResponOfChainManager *nextView) = ^(ResponOfChainManager* nextView){
        
        //设置next节点
        ResponOfChainManager *nextNode = self.nextNodeView;
        
        if (nextNode==nil) {//没有下一个节点
            
            self.nextNodeView= nextView;
            
            nextView.proNodeView= self;
            
            if (self.headerNodeView) {
                
                nextView.headerNodeView= self.headerNodeView;
                
            }else{
                
                nextView.headerNodeView= self;
                
            }
            
        }else{//有下一个节点
            
            ResponOfChainManager *lastNodeView= [self lastNodeView];
            
            lastNodeView.nextNodeView= nextView;
            
            nextView.proNodeView= lastNodeView;
            
            if (lastNodeView.headerNodeView) {
                nextView.headerNodeView= lastNodeView.headerNodeView;
            }else{
                nextView.headerNodeView= lastNodeView;
            }
        }
        
        return nextView;
    };
    
    return playViewBlock;
}

//获取最后一个节点
- (ResponOfChainManager *)lastNodeView
{
    ResponOfChainManager *nextNodeView = self.nextNodeView;
    
    if (nextNodeView== nil) {
        
        return self;
        
    }else{
        
        while (nextNodeView) {
            
            if (nextNodeView.nextNodeView==nil) {
                
                break;
            }
            nextNodeView = nextNodeView.nextNodeView;
        }
        return nextNodeView;
    }
}

//获取第一个节点
- (ResponOfChainManager *)firstNodeView
{
    return [self nodeViewForIndexPath:1];
}


//链表长度
- (NSInteger)responseChainCount
{
    NSInteger count =1;
    
    ResponOfChainManager *nextNodeView = self.nextNodeView;
    
    while (nextNodeView) {
        
        if (nextNodeView.nextNodeView==nil) {
            
            break;
        }
        nextNodeView = nextNodeView.nextNodeView;
        count++;
    }
    return count;
}

//index 查找链表
- (ResponOfChainManager *)nodeViewForIndexPath:(NSInteger)indexPath
{
    
    ResponOfChainManager *nodeView= nil;
    
    NSInteger count = [self responseChainCount];
    
    if (count<=indexPath) {
        
        nodeView= nil;
        
        return nodeView;
    }
    
    NSInteger i = 0;
    
    ResponOfChainManager *tmpNodeView= self;
    
    while (tmpNodeView) {
        
        if (indexPath==i) {
            
            nodeView = tmpNodeView;
            
            break;
        }
        
        tmpNodeView = tmpNodeView.nextNodeView;
        
        i++;
    }
    return nodeView;
}

@end
