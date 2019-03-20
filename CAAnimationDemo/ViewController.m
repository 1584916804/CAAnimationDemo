//
//  ViewController.m
//  CAAnimationDemo
//
//  Created by mini on 2019/3/19.
//  Copyright © 2019年 mini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self customContent];
    
    
    //1.基础动画( CABasicAnimation )
    //1.1 位移动画
//    [self positionAnimation];
    //1.2 旋转动画
//    [self rotateAnimation];
    //1.3 缩放动画
//    [self scaleAnimation];
    //1.4 透明度动画
//    [self opacityAnimation];
    //1.5 背景色动画(背景色 没用???)
//    [self backgroundColorAnimation];
    
    //2.0 关键帧动画 CAKeyframeAnimation
    //2.1 关键帧动画
//    [self keyFrameAnimation];
    
    //2.2 路径动画
//    [self pathAnimation];
    //2.3 抖动动画
//    [self shakeAnimation];
    
    //3  组动画( CAAnimationGroup )
    //3.1 同时动画
//    [self groupAnimation];
    
    //3.2 连续动画
//    [self goOnAnimation];
    
    
    //4. 过渡动画(转场动画)( CATransition )
    /*
     过渡动画通过 type 设置不同的动画效果, CATransition 有多种过渡效果, 但其实 Apple 官方的SDK只提供了四种:
     fade 淡出 默认
     moveIn 覆盖原图
     push 推出
     reveal 底部显示出来
     但私有API提供了其他很多非常炫的过渡动画，如 cube(立方旋转)、suckEffect(吸走)、oglFlip(水平翻转 沿y轴)、 rippleEffect(滴水效果)、pageCurl(卷曲翻页 向上翻页)、pageUnCurl(卷曲翻页 向下翻页)、cameraIrisHollowOpen(相机开启)、cameraIrisHollowClose(相机关闭)等。
     注:  因 Apple 不提供维护，并且有可能造成你的app审核不通过, 所以不建议开发者们使用这些私有API.
     */
    [self transition];
   
}

- (void)customContent{
    //
    CGFloat labelW = 100;
    CGFloat labelH  = labelW;
    CGFloat labelX = (self.view.frame.size.width - labelW ) / 2;
    CGFloat labelY = 100;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    self.label.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.label];
}

//1.基础动画( CABasicAnimation )
//1.1 移动
- (void)positionAnimation{
    
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"position.x"];
    baseAni.fromValue = @(200);
    baseAni.toValue = @(100);
    baseAni.duration = 0.6;
    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    baseAni.repeatCount = HUGE_VALF;
    baseAni.repeatDuration = 2000;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:baseAni forKey:@"positionAnimation"];
    
}

//1.2 旋转
- (void)rotateAnimation{
    
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    baseAni.toValue = @(180);
    baseAni.duration = 30;
//    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    baseAni.repeatCount = 10;
//    baseAni.repeatDuration = 2000;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:baseAni forKey:@"rotateAnimation"];
    
}
//1.3 缩放
- (void)scaleAnimation{
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAni.fromValue = @(0);
    baseAni.toValue = @(2.0);
    baseAni.duration = 1.0;
    //    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    baseAni.repeatCount = HUGE_VALF;
    //    baseAni.repeatDuration = 2000;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:baseAni forKey:@"scaleAnimation"];
}

//1.4 透明度
- (void)opacityAnimation{
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    baseAni.fromValue = @(0);
    baseAni.toValue = @(1.0);
    baseAni.duration = 1.0;
    //    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    baseAni.repeatCount = HUGE_VALF;
    //    baseAni.repeatDuration = 2000;
    baseAni.removedOnCompletion = NO;
    baseAni.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:baseAni forKey:@"opacityAnimation"];
}

//1.5 背景色动画
- (void)backgroundColorAnimation{
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    baseAni.fromValue = (id)[UIColor yellowColor].CGColor;
    baseAni.toValue = (id)[UIColor purpleColor].CGColor;
    baseAni.duration = 5.0;
    baseAni.beginTime = CACurrentMediaTime();
    //    baseAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    baseAni.repeatCount = HUGE_VALF;
//        baseAni.repeatDuration = 2000;
    baseAni.fillMode = kCAFillModeForwards;//只在前台
    baseAni.removedOnCompletion = NO;//切出界面再回来动画不会停止
//    self.label.layer.anchorPoint = CGPointMake(0, 1);
    [self.label.layer addAnimation:baseAni forKey:@"backgroundColorAnimation"];
}
//2.1 关键帧动画
- (void)keyFrameAnimation{
    CAKeyframeAnimation *keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint point1 = CGPointMake(10, 10);
    CGPoint point2 = CGPointMake(20, 20);
    CGPoint point3 = CGPointMake(30, 30);
    CGPoint point4 = CGPointMake(40, 40);
    CGPoint point5 = CGPointMake(50, 50);
    CGPoint point6 = CGPointMake(60, 60);
    CGPoint point7 = CGPointMake(70, 70);
    
    
    keyFrameAni.values = [NSArray arrayWithObjects:@(point1), point2, point3, point4, point5, point6, point7, nil];
    keyFrameAni.duration = 2.0;
    
    [self.label.layer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];
}
//2.2 路径动画
- (void)pathAnimation{
    CAKeyframeAnimation *pathAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:60 startAngle:0.0 endAngle:M_PI * 2 clockwise:true];
    pathAni.duration = 2.0;
    pathAni.path =  path1.CGPath;
    [self.label.layer addAnimation:pathAni forKey:@"pathAnimation"];
    
}


//2.3 抖动动画
- (void)shakeAnimation{
    CAKeyframeAnimation *shakeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAni.values = [NSArray arrayWithObjects:@(-M_PI / 180 * 8), @(M_PI / 180 * 8), @(-M_PI / 180 * 8), nil];
    shakeAni.duration = 1.0;
    shakeAni.repeatCount = HUGE_VALF;
    [self.label.layer addAnimation:shakeAni forKey:@"shakeAnimation"];
    
}

//3.1 组合动画
- (void)groupAnimation{
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point1 = CGPointMake(10, 10);
    CGPoint point2 = CGPointMake(20, 20);
    CGPoint point3 = CGPointMake(30, 30);
    CGPoint point4 = CGPointMake(40, 40);
    CGPoint point5 = CGPointMake(50, 50);
    CGPoint point6 = CGPointMake(60, 60);
    CGPoint point7 = CGPointMake(70, 70);
    keyAni.values = [NSArray arrayWithObjects:@(point1), point2, point3, point4, point5, point6, point7, nil];
    //颜色没用？？？？
    CABasicAnimation *bjColorAni = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    bjColorAni.toValue = (id)[UIColor greenColor].CGColor;
    
    
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAni.toValue = @(M_PI * 4);
    
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    groupAni.animations = [NSArray arrayWithObjects:keyAni, bjColorAni,rotateAni, nil];
    
    [self.label.layer addAnimation:groupAni forKey:@"groupAnimation"];
}

//3.2  连续动画
- (void)goOnAnimation{
    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"position"];
    
    ani1.fromValue = @(CGPointMake(0, 0));
    ani1.toValue = @(CGPointMake(200, 500));
    ani1.duration = 1.0;
    ani1.fillMode = kCAFillModeForwards;
    ani1.removedOnCompletion = false;
    ani1.beginTime = CACurrentMediaTime();
    [self.label.layer addAnimation:ani1 forKey:@"ani1"];
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani2.fromValue = @(0);
    ani2.toValue = @(3.0);
    ani2.duration = 1.0;
    ani2.fillMode = kCAFillModeForwards;
    ani2.removedOnCompletion = false;
    ani2.beginTime = CACurrentMediaTime() + 1.0;
    [self.label.layer addAnimation:ani2 forKey:@"ani2"];
    
    CABasicAnimation *ani3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
//    ani3.fromValue = @(CGPointMake(0, 0));
    ani3.toValue = @(M_PI * 4);
    ani3.duration = 1.0;
    ani3.fillMode = kCAFillModeForwards;
    ani3.removedOnCompletion = false;
    ani3.beginTime = CACurrentMediaTime() + 2.0;
    [self.label.layer addAnimation:ani3 forKey:@"ani3"];
    
}


- (void)transition{
    CATransition *caTransition = [CATransition animation];
    caTransition.duration = 0.5;
    caTransition.delegate = self;
    caTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];//切换时间函数
    
    
//    caTransition.type = kCATransitionReveal;//动画切换风格
    caTransition.type = kCATransitionFade;//动画切换风格
//    caTransition.type = kCATransitionMoveIn;//动画切换风格
//    caTransition.type = kCATransitionPush;//动画切换风格
    
//    caTransition.subtype = kCATransitionFromLeft;//动画切换方向
//    caTransition.subtype = kCATransitionFromRight;//动画切换方向
    caTransition.subtype = kCATransitionFromTop;//动画切换方向
//    caTransition.subtype = kCATransitionFromBottom;//动画切换方向
    
    [self.label.layer addAnimation:caTransition forKey:@"Key"];
}

@end
