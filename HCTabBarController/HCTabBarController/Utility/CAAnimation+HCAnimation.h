//
//  CAAnimation+HCAnimation.h
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface CAAnimation (HCAnimation)

/**
 * 抖动动画
 * @param repeatTimes 重复的次数
 */
+ (CAKeyframeAnimation *)HC_ShakeAnimation_RepeatTimes:(float)repeatTimes;

/**
 * 透明过渡动画
 * @param time 动画持续时间
 */
+ (CABasicAnimation *)HC_OpacityAnimation_DurationTime:(float)time;

/**
 * 缩放动画
 */
+ (CABasicAnimation *)HC_ScaleAnimation;


/**
 旋转
 */
+ (CABasicAnimation *)HC_TabBarRotationY;

/**
 放大
 */
+ (CABasicAnimation *)HC_TabBarBoundsMin;

/**
 缩小动画
 */
+ (CABasicAnimation *)HC_TabBarBoundsMax;

@end
