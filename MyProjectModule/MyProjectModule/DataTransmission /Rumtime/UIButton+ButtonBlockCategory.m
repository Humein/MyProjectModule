//
//  UIButton+ButtonBlockCategory.m
//  RuntimeAndRunloop
//
//  Created by 鑫鑫 on 2018/4/18.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#import <objc/runtime.h>
#import "UIButton+ButtonBlockCategory.h"

static NSString *keyWithMethod = @"keyWithMethod"; //关联对象的key
static NSString *keyWithBlock = @"keyWithBlock";

@implementation UIButton (ButtonBlockCategory)


// RunTime增加方法
void studyEngilsh(id self, SEL _cmd) {
    
    NSLog(@"动态添加了一个学习英语的方法");
}
/**
 resolveinstancemethod 用法
 
 // Class;给哪个类添加方法
 // SEL:添加方法
 // IMP:方法实现,函数名
 // types:方法类型(不要去死记,官方文档中有)
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == NSSelectorFromString(@"studyEngilsh")) {
        // 注意:这里需要强转成IMP类型
        class_addMethod(self, sel, (IMP)studyEngilsh, "v@:");
        return YES;
    }
    // 先恢复, 不然会覆盖系统的方法
    return [super resolveInstanceMethod:sel];
}






+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                        bgImageName:(NSString *)bgImgName
                        actionBlock:(void (^)(UIButton *sender))completion {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:bgImgName] forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     *用runtime中的函数通过key关联对象
     *
     *objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key, id _Nullable value, objc_AssociationPolicy policy)
     *id object                 表示关联者，是一个对象，变量名也是object
     *const void *key           获取被关联者的索引
     *id value                  被关联者，这里是一个block
     *objc_AssociationPolicy    policy 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
     */
    objc_setAssociatedObject(button, &keyWithMethod, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return button;
}

+ (UIButton *)button {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:button action:@selector(buttonTapAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonTapAction:(UIButton *)button {
    //通过key获取被关联对象
    //objc_getAssociatedObject(id object, const void *key)
    void (^tapBlock)(UIButton *) = objc_getAssociatedObject(button, &keyWithMethod);
    
    if (tapBlock) {
        tapBlock(button);
    }
    
    ActionBlock block2 = (ActionBlock)objc_getAssociatedObject(button, &keyWithBlock);
    if(block2){
        block2(button);
    }
}


// 为分类增加伪属性
- (void)setActionBlock:(ActionBlock)actionBlock{
    objc_setAssociatedObject(self, &keyWithBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
}

- (ActionBlock)actionBlock{
    return objc_getAssociatedObject(self ,&keyWithBlock);
}





@end
