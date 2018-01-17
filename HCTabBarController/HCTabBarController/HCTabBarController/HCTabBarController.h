//
//  HCTabBarController.h
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTabBar.h"


@interface HCTabBarController : UITabBarController
/**
 * 创建HCTabBarController
 * @param viewControllers 子控制器数组
 * @param normalImages 正常状态下图片数组
 * @param selectedImages 选中状态下的图片数组
 * @param titles 标题数组
 * @param tabBarConfig 全局样式配置
 */
- (instancetype)initWithViewControllers:(NSArray<UIViewController *>*)viewControllers
                           normalImages:(NSArray<NSString *> *)normalImages
                          selectedImages:(NSArray<NSString *> *)selectedImages
                                 titles:(NSArray<NSString *> *)titles
                           tabBarConfig:(HCTabBarConfig *)tabBarConfig;

//自定义TabBar
@property (nonatomic,strong) HCTabBar       *hc_tabbar;

@end
