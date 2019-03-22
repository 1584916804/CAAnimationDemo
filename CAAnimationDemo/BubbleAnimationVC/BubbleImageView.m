//
//  BubbleImageView.m
//  CAAnimationDemo
//
//  Created by mini on 2019/3/22.
//  Copyright © 2019年 mini. All rights reserved.
//

#import "BubbleImageView.h"

@interface BubbleImageView ()<CAAnimationDelegate>

@property (nonatomic, assign)CGFloat maxHeight; //贝塞尔曲线的最大高度
@property (nonatomic, assign)CGFloat maxWidth; //贝塞尔曲线的最大宽度

@property (nonatomic, assign)BubblePathType pathType;

//每一次动画执行的最大高度和最大宽度
@property (nonatomic, assign)CGFloat nowMaxHeight;

@property (nonatomic, assign)CGFloat nowMaxWidth;

@property (nonatomic, assign)CGPoint originPoint;

@property (nonatomic, assign)CGRect originFrame;


@end

@implementation BubbleImageView

- (instancetype)initWithMaxHeight:(CGFloat) maxHeight maxWidth: (CGFloat)maxWidth maxFrame:(CGRect)frame andSuperView: (UIView *)superView{
    self = [[BubbleImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bubble" ofType:@"png"]]];
    if (self) {
        self.originFrame = frame;
        self.frame = [self getRandomFrameWithFrame:frame];
        self.originPoint = self.frame.origin;
        [superView addSubview:self];
        self.maxHeight = maxHeight;
        self.maxWidth = maxWidth;
        self.alpha = [self makeRandomNumberFromMin:0.5 toMax:1];
        
        [self getRandomBubbleType];
        [self getRandomPathWidthAndHeight];
        [self setUpBezierPath];
    }
    return self;
}

- (void)setUpBezierPath{
    //绘制泡泡贝塞尔曲线
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    
    //起始点
    [bezierpath moveToPoint:self.originPoint];
    if (self.pathType == BubblePathTypeLeft) {
        
        CGPoint leftPoint = CGPointMake(self.originPoint.x - self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight / 4);
        CGPoint rightPoint = CGPointMake(self.originPoint.x + self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight * 3 / 4);
        CGPoint termalPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.nowMaxHeight);
        
        [bezierpath addCurveToPoint:termalPoint controlPoint1:leftPoint controlPoint2:rightPoint];
        
        
    }
    else{
        
        CGPoint leftPoint = CGPointMake(self.originPoint.x - self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight * 3 / 4);
        CGPoint rightPoint = CGPointMake(self.originPoint.x + self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight / 4);
        CGPoint termalPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.nowMaxHeight);
        [bezierpath addCurveToPoint:termalPoint controlPoint1:rightPoint controlPoint2:leftPoint];
        
    }
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    [keyFrame setDuration:2.0];
    keyFrame.path = bezierpath.CGPath;
    keyFrame.fillMode = kCAFillModeForwards;
    keyFrame.removedOnCompletion = NO;
    keyFrame.delegate = self;
    [self.layer addAnimation:keyFrame forKey:@"movingAnimation"];
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        [UIView transitionWithView:self duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } completion:^(BOOL finished) {
            if (finished) {
                [self.layer removeAllAnimations];
                
//                BubbleImageView *bubble = [[BubbleImageView alloc] initWithMaxHeight:self.maxHeight maxWidth:self.maxWidth maxFrame:self.originFrame andSuperView:self.superview];
                
                [self removeFromSuperview];
                
                
            }
        }];
    }];
    
    [CATransaction commit];
}


- (void)getRandomBubbleType{
    if (arc4random() % 2 == 1) {
        self.pathType = BubblePathTypeLeft;
    }
    else{
        self.pathType = BubblePathTypeRight;
    }
}


- (void)getRandomPathWidthAndHeight {
    self.nowMaxHeight = [self makeRandomNumberFromMin:self.maxHeight/2 toMax:self.maxHeight];
    self.nowMaxWidth = [self makeRandomNumberFromMin:0 toMax:self.maxWidth];
}

- (CGRect)getRandomFrameWithFrame: (CGRect)frame{
    CGFloat width = [self makeRandomNumberFromMin:15 toMax:self.originFrame.size.width];
    CGRect randomFrame = CGRectMake(frame.origin.x, frame.origin.y, width, width);
    return randomFrame;
}

- (CGFloat)makeRandomNumberFromMin:(CGFloat)min toMax: (CGFloat)max
{
    CGFloat precision = 100.0;
    CGFloat subtraction = ABS(max - min);
    subtraction *= precision;
    CGFloat randomNumber = arc4random() % ((int)subtraction + 1);
    
    randomNumber /= precision;
    
    randomNumber += min;
    
    return randomNumber;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
