//
//  UIView+XMBorder.h
//  XM工具类
//
//  Created by 钱海超 on 2018/6/20.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, XMExcludePoint) {
    XMExcludeStartPoint = 1 << 0,
    XMExcludeEndPoint = 1 << 1,
    XMExcludeAllPoint = ~0UL
};

@interface UIView (XMBorder)

- (void)xm_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)xm_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)xm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)xm_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)xm_removeTopBorder;
- (void)xm_removeLeftBorder;
- (void)xm_removeBottomBorder;
- (void)xm_removeRightBorder;


- (void)xm_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XMExcludePoint)edge;
- (void)xm_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XMExcludePoint)edge;
- (void)xm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XMExcludePoint)edge;
- (void)xm_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(XMExcludePoint)edge;

@end
