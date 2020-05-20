//
//  AnimationExample.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/9/30.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AnimationExample.h"
@interface AnimationExample()
{
    UIImageView *imageView;
}
@end
@implementation AnimationExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"btn_link_fill"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    //添加长按手势
    UILongPressGestureRecognizer *recognize = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    //长按响应时间
    recognize.minimumPressDuration = 1;
    [imageView addGestureRecognizer:recognize];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)longPress {
    CABasicAnimation *animation = (CABasicAnimation *)[imageView.layer animationForKey:@"rotation"];
    if (animation == nil) {
        [self shakeImage];
    }else {
        [self resume];
    }
}

/// 如果点击图标外区域，停止抖动 touchesBegan 定位View XXMARK  手势冲突
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    //转换坐标系，判断touch点是否在imageView内，在的话，仍然抖动，否则停止抖动
    CGPoint p = [self.view convertPoint:point toView:imageView];
    if (![imageView pointInside:p withEvent:event]) {
        NSLog(@"xxxxxxx");
        [self pause];
    }
}

//layer.speed
/* The rate of the layer. Used to scale parent time to local time, e.g.
 * if rate is 2, local time progresses twice as fast as parent time.
 * Defaults to 1. */
//这个参数的理解比较复杂，我的理解是所在layer的时间与父layer的时间的相对速度，为1时两者速度一样，为2那么父layer过了一秒，而所在layer过了两秒（进行两秒动画）,为0则静止。
- (void)pause {
    imageView.layer.speed = 0.0;
}

- (void)resume {
    imageView.layer.speed = 1.0;
}

//抖动
- (void)shakeImage {
//     APP图标长按抖动效果的实现
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    [animation setDuration:0.08];
    
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [imageView.layer addAnimation:animation forKey:@"rotation"];
}


//浮动
-(void)upAndDown:(UIView *)view{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat duration = 1.f;
    CGFloat height = 7.f;
    CGFloat currentY = view.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentY),@(currentY - height/4),@(currentY - height/4*2),@(currentY - height/4*3),@(currentY - height),@(currentY - height/ 4*3),@(currentY - height/4*2),@(currentY - height/4),@(currentY)];
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
    
    
}

//心跳
-(void)heartShake:(UIView *)view{
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.fromValue= @(0.95);
    springAnimation.toValue=@(1);
    springAnimation.mass=1;
    springAnimation.stiffness=50;
    springAnimation.damping=10;
    springAnimation.initialVelocity=50;
    springAnimation.duration= 1;
    springAnimation.repeatCount = CGFLOAT_MAX;
    
//    如果不会执行动画、
    springAnimation.removedOnCompletion = NO;
    
    [view.layer addAnimation:springAnimation forKey:@"springAnimation"];
}

@end
