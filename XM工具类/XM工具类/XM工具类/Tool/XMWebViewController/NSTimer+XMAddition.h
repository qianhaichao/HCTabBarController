//
//  NSTimer+Addition.h
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (XMAddition)
/**
 暂停
 */
- (void)xm_pauseTime;
/**
 获取内容所在当前时间
 */
- (void)xm_webPageTime;
/**
 获取当前时间timeInterval后的时间
 */
- (void)xm_webPageTimeWithTimerInterval:(NSTimeInterval)timeInterval;

@end
