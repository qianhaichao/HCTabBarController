//
//  HCTabBar.h
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTabBarConfig.h"

@class HCTabBar;
@protocol HCTabBarDelegate<NSObject>

- (void)tabBar:(HCTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex;

@end

@interface HCTabBar : UITabBar

/**
 * 创建HCTabBar
 * @param normalImages 正常状态下图片数组
 * @param selectedImages 选中状态下的图片数组
 * @param titles 标题数组
 * @param tabBarConfig 全局样式配置
 */
- (instancetype)initWithFrame:(CGRect)frame
                 normalImages:(NSArray<NSString *> *)normalImages
               selectedImages:(NSArray<NSString *> *)selectedImages
                       titles:(NSArray<NSString *> *)titles
                 tabBarConfig:(HCTabBarConfig *)tabBarConfig;

//代理
@property (nonatomic,weak) id<HCTabBarDelegate> hc_delegate;

//索引 默认选择0
@property (nonatomic,assign) NSInteger       selectedIndex;

@end
