//
//  BubbleAnimationVC.m
//  CAAnimationDemo
//
//  Created by mini on 2019/3/22.
//  Copyright © 2019年 mini. All rights reserved.
//

#import "BubbleAnimationVC.h"
#import "BubbleImageView.h"


@interface BubbleAnimationVC ()

@property (nonatomic, assign)NSInteger bubbleNumber;

@end

@implementation BubbleAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.bubbleNumber = 0;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.bubbleNumber <= 30) {
        
        BubbleImageView *bubbleImageView = [[BubbleImageView alloc]initWithMaxHeight:self.view.bounds.size.height  maxWidth: self.view.bounds.size.width  maxFrame:CGRectMake([self makeRandomNumberFromMin:0 toMax:self.view.bounds.size.width], self.view.center.y, 50, 50) andSuperView:self.view];
        self.bubbleNumber++;
    }
    
}

- (CGFloat)makeRandomNumberFromMin:(CGFloat)min toMax: (CGFloat)max
{
    NSInteger precision = 100;
    
    CGFloat subtraction = ABS(max - min);
    
    subtraction *= precision;
    
    CGFloat randomNumber = arc4random() % ((int)subtraction+1);
    
    randomNumber /= precision;
    
    randomNumber += min;
    
    //返回结果
    return randomNumber;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
