//
//  UITableViewCell+AnimationType.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
//YYKitMacro.h  runtime 添加属性 宏定义
#ifndef YYSYNTH_DYNAMIC_PROPERTY_CTYPE
#define YYSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
_type_ cValue = { 0 }; \
NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
[value getValue:&cValue]; \
return cValue; \
}
#endif


#ifndef YYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif


typedef NS_ENUM(NSInteger, UITableViewCellDisplayAnimationStyle) {
    UITableViewCellDisplayAnimationTop = 0, // line by line
    UITableViewCellDisplayAnimationLeft = 1,
    UITableViewCellDisplayAnimationBottom = 2,
    UITableViewCellDisplayAnimationRight = 3,
    UITableViewCellDisplayAnimationTopTogether = 4, // together
    UITableViewCellDisplayAnimationLeftTogether = 5,
    UITableViewCellDisplayAnimationBottomTogether = 6,
    UITableViewCellDisplayAnimationRightTogether = 7,
    UITableViewCellDisplayAnimationFadeIn = 8, // fade in line by line
    UITableViewCellDisplayAnimationFadeInTogether = 9, // fade in together
};

@interface UITableViewCell (AnimationType)

#pragma mark ---- 1:利用关联对象为分类增加伪属性

@property (nonatomic, assign, getter=isDisplayed) BOOL displayed;

/** 添加cell显示动画方法
 * @param tableView tableView
 * @param indexPath cell 位置
 * @param animationStyle cell 显示动画类型
 */
- (void)tableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath animationStyle:(UITableViewCellDisplayAnimationStyle)animationStyle;


@end
