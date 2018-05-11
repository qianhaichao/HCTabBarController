//
//  HCTabBarConfig.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "HCTabBarConfig.h"
#import "HCTabBarController.h"
#import "HCTabBarItem.h"
#import "UIView+HCFrame.h"

@implementation HCTabBarConfig

//单例模式
static HCTabBarConfig *_shareInstance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[HCTabBarConfig alloc] init];
    });
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if(_shareInstance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /*********TabBarItem默认是配置**********/
        _layoutType = HCConfigTabBarItemLayoutType_Default;
        _normalTitleColor = [UIColor colorWithHexString:@"#808080"];
        _selectedTitleColor = [UIColor colorWithHexString:@"#d81e06"];
        _imageSize = CGSizeMake(28, 28);
        
        /*********TabBar默认是配置**********/
        _tabBarItemAnimateType = HCConfigTabBarItemAnimateType_None;
        _isHideTabBarTopLine = YES;
        _tabBarTopLineBgColor = [UIColor lightGrayColor];
        _tabBarBgColor = [UIColor whiteColor];
        
        /*********Badge默认是配置**********/
        _badgeAnimateType = HCConfigBadgeValueAnimateType_None;
        _badgeTextColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _badgeBgColor = [UIColor colorWithHexString:@"#FF4040"];
        
    }
    return self;
}

#pragma mark - Badge相关设置

//setter方法
- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    _badgeTextColor = badgeTextColor;
    
    for (HCTabBarItem *item in [self getTabBarItems]) {
        item.badgeValue.badgeLabel.textColor = badgeTextColor;
    }
}
- (void)setBadgeBgColor:(UIColor *)badgeBgColor
{
    _badgeBgColor = badgeBgColor;
    
    for (HCTabBarItem *item in [self getTabBarItems]) {
        item.badgeValue.badgeLabel.backgroundColor = badgeBgColor;
    }
}

- (void)setBadgeSize:(CGSize)badgeSize
{
    _badgeSize = badgeSize;
    for (HCTabBarItem *item in [self getTabBarItems]) {
        item.badgeValue.size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset
{
    _badgeOffset = badgeOffset;
    for (HCTabBarItem *item in [self getTabBarItems]) {
        item.badgeValue.x += badgeOffset.x;
        item.badgeValue.y += badgeOffset.y;
    }
}
- (void)setBadgeRadius:(CGFloat)badgeRadius
{
    _badgeRadius = badgeRadius;
    for (HCTabBarItem *item in [self getTabBarItems]) {
        item.badgeValue.layer.cornerRadius = badgeRadius;
    }
}


//对单个Badge进行圆角设置
- (void)badgeRadius:(CGFloat)badgeRadius atIndex:(NSInteger)index
{
    HCTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.badgeLabel.layer.cornerRadius = badgeRadius;
}

//显示原点徽标
- (void)showPointBadgeAtIndex:(NSInteger)index
{
    HCTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.hidden = NO;
    item.badgeValue.badgeType = HCBadgeValueType_Point;
}

//显示new徽标
- (void)showNewBadgeAtIndex:(NSInteger)index
{
    HCTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.hidden = NO;
    item.badgeValue.badgeLabel.text = @"new";
    item.badgeValue.badgeType = HCBadgeValueType_New;
}

//显示数字徽标
- (void)showNumberBadge:(NSString *)badgeNumber atIndex:(NSInteger)index
{
    HCTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.hidden = [badgeNumber isEqualToString:@"0"] || [badgeNumber integerValue] <= 0;
    item.badgeValue.badgeLabel.text = [badgeNumber integerValue] >= 100 ? @"99+" : badgeNumber;
    item.badgeValue.badgeType = HCBadgeValueType_Number;
}

//隐藏徽标
- (void)hideBadgeAtIndex:(NSInteger)index
{
    [self getTabBarItemAtIndex:index].badgeValue.badgeLabel.hidden = YES;
}

#pragma mark - 自定义控件
//添加自定义按钮
- (void)addCustomTabBarItem:(UIButton *)customItem adIndex:(NSInteger)index itemClickBlock:(HCCustomItemClickBlock)customItemClickBlock
{
    customItem.tag = index;
    [customItem addTarget:self action:@selector(customItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.customItemBlock = customItemClickBlock;
    [self.tabBarController.hc_tabbar addSubview:customItem];
}
//自定义按钮回调方法
- (void)customItemClick:(UIButton *)sender
{
    //执行回调
    if(self.customItemBlock){
        self.customItemBlock(sender, sender.tag);
    }
}

#pragma mark - HCTabBarItem相关操作

//获取对应索引的HCTabBarItem
- (HCTabBarItem *)getTabBarItemAtIndex:(NSInteger)index
{
    for (int i = 0; i < [self getTabBarItems].count; i ++ ) {
        UIView *view = [self getTabBarItems][i];
        if([view isKindOfClass:[HCTabBarItem class]] && i == index){
            return (HCTabBarItem *)view;
        }
        
    }
    return nil;
}

//获取HCTabBar内部的HCTabBarItem
- (NSMutableArray *)getTabBarItems
{
    NSMutableArray *tempSubviewArr = [NSMutableArray array];
    for (UIView *view in self.tabBarController.hc_tabbar.subviews) {
        if([view isKindOfClass:[HCTabBarItem class]]){
            [tempSubviewArr addObject:(HCTabBarItem *)view];
        }
    }
    return tempSubviewArr;
}

@end
