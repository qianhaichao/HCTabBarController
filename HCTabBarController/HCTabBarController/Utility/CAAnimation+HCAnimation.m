//
//  CAAnimation+HCAnimation.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "CAAnimation+HCAnimation.h"


#define Angle2Rad(angle)  ((angle) / 180.0 * M_PI)

@implementation CAAnimation (HCAnimation)

/**
 * 抖动动画
 * repeatTimes 重复的次数
 */
+ (CAKeyframeAnimation *)HC_ShakeAnimation_RepeatTimes:(float)repeatTimes
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = @[@(Angle2Rad(-15)),@(Angle2Rad(-10)),@(Angle2Rad(-7)),@(Angle2Rad(-5)),@(Angle2Rad(0)),@(Angle2Rad(5)),@(Angle2Rad(-7)),@(Angle2Rad(10)),@(Angle2Rad(15))];
    anim.repeatCount = repeatTimes;
    return anim;
}

/**
 * 透明过渡动画
 * @param time 动画持续时间
 */
+ (CABasicAnimation *)HC_OpacityAnimation_DurationTime:(float)time
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @1.0;
    anim.toValue = @0.2;
    anim.repeatCount = 3;
    anim.duration = time;
    anim.autoreverses = YES;
    return anim;
}
/**
 * 缩放动画
 */
+ (CABasicAnimation *)HC_ScaleAnimation
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"scale"];
    anim.toValue = @1.2f;
    anim.duration = 0.3;
    anim.repeatCount = 3;
    anim.autoreverses = YES;
    return anim;
}

+ (CABasicAnimation *)HC_TabBarRotationY
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    return animation;
}
+ (CABasicAnimation *)HC_TabBarBoundsMin
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    anim.toValue =  [NSValue valueWithCGPoint:CGPointMake(12, 12)];
    return anim;
}
+ (CABasicAnimation *)HC_TabBarBoundsMax
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(46, 46)];
    return anim;
}

@end
