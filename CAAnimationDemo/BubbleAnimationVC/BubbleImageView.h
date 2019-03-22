//
//  BubbleImageView.h
//  CAAnimationDemo
//
//  Created by mini on 2019/3/22.
//  Copyright © 2019年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BubblePathType) {
    BubblePathTypeLeft = 0,
    BubblePathTypeRight = 1,
};


@interface BubbleImageView : UIImageView

- (instancetype)initWithMaxHeight:(CGFloat) maxHeight maxWidth: (CGFloat)maxWidth maxFrame:(CGRect)frame andSuperView: (UIView *)superView;

@end

NS_ASSUME_NONNULL_END
