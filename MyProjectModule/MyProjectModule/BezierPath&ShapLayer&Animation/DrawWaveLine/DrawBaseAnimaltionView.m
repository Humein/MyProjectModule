//
//  DrawBaseAnimaltionView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/22.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DrawBaseAnimaltionView.h"
#import "POP.h"
@interface DrawBaseAnimaltionView()
@property(nonatomic,strong)CALayer *myCriLayer;
@property(nonatomic,strong)CAShapeLayer *myLLlayer;

@property (nonatomic,assign) BOOL animated;

@end
@implementation DrawBaseAnimaltionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        心跳
        [self addLayer:frame];

    
    }
    return self;
}

-(void)imageAnimaltion:(NSMutableArray *)imageArray{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.frame;
    [self addSubview:imageView];
//    NSMutableArray *imgArray = [NSMutableArray array];
//    for (int i=0; i<1; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"placehold%d.png",i]];
//        [imgArray addObject:image];
//    }
    imageView.animationImages = imageArray;
    imageView.animationDuration = 6*0.15;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
}




-(void)addLayer:(CGRect)frame{
    self.myCriLayer=[CALayer layer];
    [self.myCriLayer pop_removeAllAnimations];
    self.myCriLayer.opacity = 1.0;
    self.myCriLayer.transform = CATransform3DIdentity;
    [self.myCriLayer setMasksToBounds:YES];
    [self.myCriLayer setBackgroundColor:[UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1].CGColor];
    [self.myCriLayer setCornerRadius:15.0f];
    [self.myCriLayer setBounds:frame];
    [self.layer addSublayer:self.myCriLayer];
    [self performAnimation];

    
    
     UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(0,self.frame.size.height)];
    
    self.myLLlayer=[CAShapeLayer layer];
    [self.myLLlayer pop_removeAllAnimations];

    
    self.myLLlayer.strokeColor = [UIColor blackColor].CGColor;
    self.myLLlayer.fillColor = nil;
    self.myLLlayer.path = path1.CGPath;
    self.myLLlayer.lineWidth = 20;
    [self.layer addSublayer:self.myLLlayer];
    
    
 
    

}


-(void)performAnimation
{
    [self.myCriLayer pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    if (self.animated) {
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }else{
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    }
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  //不同的类型 心跳会不一样
    
    self.animated = !self.animated;
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            
            [self performAnimation];  //当动画结束后又递归调用，让它产生一种心跳的效果
        }
    };
    
    [self.myCriLayer pop_addAnimation:anim forKey:@"Animation"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
