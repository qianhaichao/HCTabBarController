//
//  XMWebProgressLayer.h
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface XMWebProgressLayer : CAShapeLayer
/** 开始加载 */
- (void)xm_startLoad;

/** 完成加载 */
- (void)xm_finishedLoadWithError:(NSError *)error;

/** 关闭时间 */
- (void)xm_closeTimer;

- (void)xm_webViewPathChanged:(CGFloat)estimatedProgress;
@end
