//
//  NSObject+RuntimeHelper.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "NSObject+RuntimeHelper.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "AbstractItem.h"

@implementation NSObject (RuntimeHelper)


#pragma mark - Plubic Methods

/**
 消息机制
 */
-(void)sendMessage{
        
    // 1.创建对象
    AbstractItem *msg = ((AbstractItem * (*)(id, SEL))objc_msgSend)((id)[AbstractItem class], @selector(alloc));

    // 2.初始化对象
    msg = ((AbstractItem * (*)(id, SEL))objc_msgSend)((id)msg, @selector(init));
    
    // 3.调用带一个参数但无返回值的方法
    ((void (*)(id, SEL, NSString *))objc_msgSend)((id)msg, @selector(hasArguments:), @"带一个参数，但无返回值");
}

- (void)hasArguments:(NSString *)arg {
  NSLog(@"%s was called, and argument is %@", __FUNCTION__, arg);
}

/**
 RunTime增加方法
 */
-(void)runTimeAddInstanceMethod{
    // UIButton+ButtonBlockCategory
    UIButton *newBtn = [UIButton  new];
    [newBtn performSelector:@selector(studyEngilsh)];
}

/**
 交换方法
 */
+ (void)pxy_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    
    SEL originalSeletor = originalSelector;
    SEL swizzledSeletor = swizzledSelector;
    
    Method originMethod = class_getInstanceMethod(class, originalSeletor);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSeletor);
    
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class, originalSeletor, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加并替换成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP.
        class_replaceMethod(class, swizzledSeletor, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
#warning - 分解
    /**
     - class_addMethod
       - 添加方法
     - class_replaceMethod
       - 替换方法
     - method_exchangeImplementations
       - 交换方法
     
     - 替换系统方法流程
       - class_addMethod 确认是否已经实现
         - 是 class_replaceMethod 替换之前方法
         - 否 method_exchangeImplementations 直接交换
     
     - 添加新方法流程
       - class_addMethod 添加方法，并返回结果
         - 是 不做操作
         - 否 method_exchangeImplementations 直接交换
     */
}

/**
 消息转发 https://www.jianshu.com/p/1c8f708653c0
 */


/**
 动态关联属性
 */
// 1 __weak 实现 weak 修饰
/**
 添加了一个中间角色 block，再辅以 weak 关键字就实现了具备 weak 属性的 associated object
 */
- (void)setObjc_weak_id:(id)objc_weak_id {
    id __weak weakObject = objc_weak_id;
    id (^block)(void) = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(objc_weak_id), block, OBJC_ASSOCIATION_COPY);
}

- (id)objc_weak_id {
    id (^block)(void) = objc_getAssociatedObject(self, @selector(objc_weak_id));
    return (block ? block() : nil);
}


/**
 获取类中的所有属性
 */
- (void)pxy_printPropertyList {
    
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ PropertyList Start -----",NSStringFromClass(class));
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSLog(@"%s ---- %s",property_getName(property),property_getAttributes(property));
    }
    free(properties);
    NSLog(@"----- Class: %@ PropertyList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

/**
 获取类中的所有成员变量
 */
- (void)pxy_printIvaList {
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ IvaList Start -----",NSStringFromClass(class));
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(class, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s ---- %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    free(ivars);
    NSLog(@"----- Class: %@ IvaList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

/**
 获取类中的所有方法
 */
- (void)pxy_printMethodList {
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ MethodList Start -----",NSStringFromClass(class));
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i ++) {
        Method method = methodList[i];
        NSLog(@"Method: ---- %@",NSStringFromSelector(method_getName(method)));
    }
    
    NSLog(@"----- Class: %@ MethodList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

/**
 获取协议列表
 */
- (void)pxy_printProtocolList {
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ ProtocolList Start -----",NSStringFromClass(class));
    
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    for (int i = 0; i < count; i ++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        NSLog(@"Protocol: ---- %s",protocolName);
    }
    
    NSLog(@"----- Class: %@ ProtocolList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

/**
 动态创建类和对象
 */
- (void)creatClass {
    //定义一个 Person 类, 继承自 NSObject
    Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
    //添加属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    class_addProperty(Person, "name", attrs, 3);
    //添加方法
    class_addMethod(Person, @selector(name), (IMP)nameGetter, "@@:");
    class_addMethod(Person, @selector(setName:), (IMP)nameSetter, "v@:@");
    //注册该类
    objc_registerClassPair(Person);
    
    //获取实例
    id instance = [[Person alloc] init];
    NSLog(@"%@", instance);
    [instance setName:@"hxn"];
    
    NSLog(@"%@", [instance name]);
    
    
}
//get方法
NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    return object_getIvar(self, ivar);
}
//set方法
void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}

/**
私有属性的访问与修改
*/

//  KVC 方式访问和修改私有变量
- (void)printSonNameWithKVC
{
    AbstractItem *son = [[AbstractItem alloc] init];
    
    // 修改前
    NSString *name = [son valueForKey:@"name"];
    NSLog(@"-name:%@", name);
    
    // 修改后
    [son setValue:@"Jabit" forKey:@"name"];
    NSString *nameReset = [son valueForKey:@"name"];
    NSLog(@"-nameReset:%@", nameReset);
}

//Runtime 方式访问和修改私有变量
- (void)printSonNameWithRuntime
{
    AbstractItem *son = [[AbstractItem alloc] init];
    
    unsigned int count = 0;
    Ivar *members = class_copyIvarList([AbstractItem class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = members[i];
        const char *memberName = ivar_getName(ivar);
        const char *memberType = ivar_getTypeEncoding(ivar);
        //依次打印属性名称和属性类型
        NSLog(@"%s : %s", memberName, memberType);
        
        if (strcmp(memberName, "_name") == 0) {
            // 修改前
            NSString *name = (NSString *)object_getIvar(son, members[i]);
            NSLog(@"-name:%@", name);
            
            // 修改后
            object_setIvar(son, members[i], @"Jabit");
            NSString *nameReset = (NSString *)object_getIvar(son, members[i]);
            NSLog(@"-nameReset:%@", nameReset);
            
            break;
        }
    }
}
@end
