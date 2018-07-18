//
//  XMWebProgressLayer.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "XMWebProgressLayer.h"
#import "NSTimer+XMAddition.h"

static NSTimeInterval const ProgressTimeInterval = 0.03;
@interface XMWebProgressLayer()
@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat plusWidth;
@end


@implementation XMWebProgressLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initBezierPath];
    }
    return self;

}

- (void)initBezierPath {
    //绘制贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(0, 3)];
    //终点
    [path addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width,3)];

    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.005;
    self.lineWidth = 2;
    self.strokeColor = [UIColor redColor].CGColor;


    _timer = [NSTimer scheduledTimerWithTimeInterval:ProgressTimeInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
    [_timer xm_pauseTime];

}

// 设置进度条增加的进度
- (void)pathChanged:(NSTimer *)timer{
    self.strokeEnd += _plusWidth;
    if (self.strokeEnd > 0.60) {
        _plusWidth = 0.002;
    }

    if (self.strokeEnd > 0.85) {
        _plusWidth = 0.0007;
    }

    if (self.strokeEnd > 0.93) {
        _plusWidth = 0;
    }
}

//在KVO 计算  实际的读取进度时,调用改方法
- (void)xm_webViewPathChanged:(CGFloat)estimatedProgress {
    self.strokeEnd = estimatedProgress;

}

- (void)xm_startLoad {
    [_timer xm_webPageTimeWithTimerInterval:ProgressTimeInterval];

}

- (void)xm_finishedLoadWithError:(NSError *)error {
    CGFloat timer;
    if (error == nil) {
        [self xm_closeTimer];
        timer = 0.5;
        self.strokeEnd = 1.0;
    }else {
        timer = 45.0;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (timer == 45.0) {
            [self xm_closeTimer];

        }
        self.hidden = YES;
        [self removeFromSuperlayer];

    });
}

#pragma mark - private
- (void)xm_closeTimer {

    [_timer invalidate];
    _timer = nil;

}

- (void)dealloc {
    [self xm_closeTimer];
}


@end
