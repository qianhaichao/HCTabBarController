//
//  HCTabBarConfig.h
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+HCHex.h"
@class HCTabBarController;

//TabBar高度
#define kTabBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)
#define kTabBarItemHeight  49

/*******布局枚举******/
typedef NS_ENUM(NSUInteger, HCConfigTabBarItemLayoutType) {
    HCConfigTabBarItemLayoutType_Default, //默认布局模式:图文
    HCConfigTabBarItemLayoutType_Image,   //图片模式
};

/*******TabBarItem动画枚举******/
typedef NS_ENUM(NSUInteger, HCConfigTabBarItemAnimateType) {
    HCConfigTabBarItemAnimateType_None, //无动画
    HCConfigTabBarItemAnimateType_RotationY, //Y轴旋转
    HCConfigTabBarItemAnimateType_BoundsMin, //缩小
    HCConfigTabBarItemAnimateType_BoundsMax, //放大
    HCConfigTabBarItemAnimateType_Scale //缩放动画
};

/*******BadgeValue动画枚举******/
typedef NS_ENUM(NSUInteger, HCConfigBadgeValueAnimateType) {
    HCConfigBadgeValueAnimateType_None, //无动画
    HCConfigBadgeValueAnimateType_Shake, //抖动动画
    HCConfigBadgeValueAnimateType_Opacity, //有名过渡动画
    HCConfigBadgeValueAnimateType_Scale //缩放动画
};

//自定义中间按钮点击回调
typedef void(^HCCustomItemClickBlock)(UIButton *customItem,NSInteger index);


@interface HCTabBarConfig : NSObject

//单例模式
+ (instancetype)sharedInstance;


/***************************TabBarItem的配置*******************************/
//TabBarItem的布局类型(默认HCConfigTabBarItemLayoutType_Default 图文混合)
@property (nonatomic,assign) HCConfigTabBarItemLayoutType       layoutType;
//正常状态文字颜色(默认是 #808080)
@property (nonatomic,strong) UIColor       *normalTitleColor;
//选中状态文字颜色(默认是 #d81e06)
@property (nonatomic,strong) UIColor       *selectedTitleColor;
//图片尺寸(默认是 28*28)
@property (nonatomic,assign) CGSize         imageSize;


/***************************TabBar的配置*******************************/
//TabBarItem动画类型(默认HCConfigTabBarItemAnimateType_None)
@property (nonatomic,assign) HCConfigTabBarItemAnimateType       tabBarItemAnimateType;
//是否隐藏TabBar顶部分割线(默认是 YES)
@property (nonatomic,assign) BOOL       isHideTabBarTopLine;
//TabBar顶部分割线的颜色(默认是 lightGrayColor)
@property (nonatomic,strong) UIColor       *tabBarTopLineBgColor;
//TabBar的背景颜色(默认是 whiteColor)
@property (nonatomic,strong) UIColor       *tabBarBgColor;


/***************************TabBarController的配置*******************************/
@property (nonatomic,strong) HCTabBarController       *tabBarController;


/***************************BadgeValue的配置*******************************/
//badgeAnimateType 徽标显示动画(默认HCConfigBadgeValueAnimateType_None)
@property (nonatomic,assign) HCConfigBadgeValueAnimateType       badgeAnimateType;
//badgeTextColor 徽标文字颜色(默认是 #FFFFFF)
@property (nonatomic,strong) UIColor       *badgeTextColor;
//badgeBgColor 徽标背景颜色(默认是 #FF4040)
@property (nonatomic,strong) UIColor       *badgeBgColor;
//badgeSize 徽标大小(如果没有特殊需求，请勿修改此属性,此属性只有在控制器加载完成后设置才有效)
@property (nonatomic,assign) CGSize       badgeSize;
//badgeOffset 徽标偏移位置(如果没有特殊需求，请勿修改此属性,此属性只有在控制器加载完成后设置才有效)
@property (nonatomic,assign) CGPoint       badgeOffset;
//badgeRadius 圆角大小(如果没有特殊需求，请勿修改此属性,此属性只有在控制器加载完成后设置才有效,一般配合badgeSize使用)
@property (nonatomic,assign) CGFloat       badgeRadius;

//对单个Badge进行圆角设置
- (void)badgeRadius:(CGFloat)badgeRadius atIndex:(NSInteger)index;

/**
 * 下面这些针对徽标操作是针对全局的，例如通过[[HCTabBarConfig sharedInstance] showPointBadgeAtIndex:1]
 */

//显示原点徽标
- (void)showPointBadgeAtIndex:(NSInteger)index;

//显示new徽标
- (void)showNewBadgeAtIndex:(NSInteger)index;

//显示数字徽标
- (void)showNumberBadge:(NSString *)badgeNumber atIndex:(NSInteger)index;

//隐藏徽标
- (void)hideBadgeAtIndex:(NSInteger)index;


/***************************自定义按钮******************************/
@property (nonatomic,copy)   HCCustomItemClickBlock       customItemBlock;

//添加自定义按钮(目前只支持自定义按钮,后续会开发自定义其他控件)
- (void)addCustomTabBarItem:(UIButton *)customItem adIndex:(NSInteger)index itemClickBlock:(HCCustomItemClickBlock)customItemClickBlock;

@end
