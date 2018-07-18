//
//  NSTimer+Addition.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "NSTimer+XMAddition.h"

@implementation NSTimer (XMAddition)

/**
 暂停
 */
- (void)xm_pauseTime
{
    //判断定时器是否有效
    if(!self.isValid){
        return;
    }
    //停止定时器
    [self setFireDate:[NSDate distantFuture]];
}
/**
 获取内容所在当前时间
 */
- (void)xm_webPageTime
{
    //判断定时器是否有效
    if(!self.isValid){
        return;
    }
    [self setFireDate:[NSDate date]];
}

/**
 获取当前时间timeInterval后的时间
 */
- (void)xm_webPageTimeWithTimerInterval:(NSTimeInterval)timeInterval
{
    //判断定时器是否有效
    if(!self.isValid){
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
}

@end
