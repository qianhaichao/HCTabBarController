//
//  HCTabBarController.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "HCTabBarController.h"

@interface HCTabBarController ()<HCTabBarDelegate>

@end

@implementation HCTabBarController

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
                           tabBarConfig:(HCTabBarConfig *)tabBarConfig
{
    if(self  = [super init]){
        
        self.viewControllers = viewControllers;
        
        //创建自定义TabBar
        self.hc_tabbar = [[HCTabBar alloc] initWithFrame:self.tabBar.frame normalImages:normalImages selectedImages:selectedImages titles:titles tabBarConfig:tabBarConfig];
        self.hc_tabbar.hc_delegate = self;
        
        //KVC替换系统的TabBar
        [self setValue:self.hc_tabbar forKeyPath:@"tabBar"];
        
        [HCTabBarConfig sharedInstance].tabBarController = self;
        
        //KVO
        [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        
        //默认选中第0个元素
        self.selectedIndex = 0;
        
    }
    return self;
}

//监听索引
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //获取索引值
    NSInteger selectedIndex = [change[@"new"] integerValue];
    //赋值tabBar的索引
    self.hc_tabbar.selectedIndex = selectedIndex;
}

#pragma mark - HCTabBarDelegate
- (void)tabBar:(HCTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
}


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

@end
