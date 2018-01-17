//
//  HCTabBar.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "HCTabBar.h"
#import "HCTabBarItem.h"
#import "UIView+HCFrame.h"
#import "CAAnimation+HCAnimation.h"

@interface HCTabBar()
@property (nonatomic,strong) NSMutableArray       *tabBarItems;
@property (nonatomic,strong) NSMutableArray       *selectedImages;
@property (nonatomic,strong) NSMutableArray       *normalImages;
@property (nonatomic,strong) NSMutableArray       *titles;
@end

@implementation HCTabBar

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
                 tabBarConfig:(HCTabBarConfig *)tabBarConfig
{
    if(self = [super initWithFrame:frame]){
        
        //创建子控件
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HCTabBarItem *tabBarItem = [[HCTabBarItem alloc] init];
            tabBarItem.imageView.image = [UIImage imageNamed:normalImages[idx]];
            tabBarItem.titleLabel.textColor = [HCTabBarConfig sharedInstance].normalTitleColor;
            tabBarItem.titleLabel.text = title;
            tabBarItem.tag = idx;
            tabBarItem.layoutType = [HCTabBarConfig sharedInstance].layoutType;
            [self addSubview:tabBarItem];
            
            //记录子控件
            [self.tabBarItems addObject:tabBarItem];
            
            //添加手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabBarItemClick:)];
            [tabBarItem addGestureRecognizer:tapGesture];
            
            //记录图片和文字
            self.titles = [NSMutableArray arrayWithArray:titles];
            self.selectedImages = [NSMutableArray arrayWithArray:selectedImages];
            self.normalImages = [NSMutableArray arrayWithArray:normalImages];
        }];
        
        //设置属性
        self.backgroundColor = [HCTabBarConfig sharedInstance].tabBarBgColor;
        
        //设置分割线
        [self topLineIsHide:[HCTabBarConfig sharedInstance].isHideTabBarTopLine];
        
    }
    return self;
}

#pragma mark - 处理分割线
- (void)topLineIsHide:(BOOL)isHideTopLine
{
    UIColor *color = [UIColor clearColor];
    if(!isHideTopLine){
        color = [HCTabBarConfig sharedInstance].tabBarTopLineBgColor;
    }
    
    CGRect rect = CGRectMake(0, 0, self.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

#pragma mark - 事件监听
- (void)tabBarItemClick:(UITapGestureRecognizer *)tapGesture
{
    [self configSelectedStyleAtIndex:tapGesture.view.tag];
    
    //执行回调
    if(self.hc_delegate && [self.hc_delegate respondsToSelector:@selector(tabBar:didSelectedIndex:)]){
        [self.hc_delegate tabBar:self didSelectedIndex:tapGesture.view.tag];
    }
}

#pragma mark - setter方法
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [self configSelectedStyleAtIndex:selectedIndex];
}

#pragma mark - 设置选中后的效果
- (void)configSelectedStyleAtIndex:(NSInteger)index
{
    HCTabBarConfig *tabBarConfig = [HCTabBarConfig sharedInstance];
    
    [self.tabBarItems enumerateObjectsUsingBlock:^(HCTabBarItem *  _Nonnull tabBarItem, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(idx == index){ //选中
            tabBarItem.titleLabel.textColor = tabBarConfig.selectedTitleColor;
            tabBarItem.imageView.image = [UIImage imageNamed:self.selectedImages[idx]];
            
            //设置选中动画
            HCConfigTabBarItemAnimateType animateType = tabBarConfig.tabBarItemAnimateType;
            if(animateType == HCConfigTabBarItemAnimateType_RotationY){ //旋转
                [tabBarItem.imageView.layer addAnimation:[CAAnimation HC_TabBarRotationY] forKey:@"rotationAnimationY"];
            }else if (animateType == HCConfigTabBarItemAnimateType_Scale){ //缩放
                CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
                CGPoint point = tabBarItem.imageView.frame.origin;
                point.y -= 15;
                anim.toValue = [NSNumber numberWithFloat:point.y];
                
                CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                anim1.toValue = [NSNumber numberWithFloat:1.3f];
                
                CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
                groupAnimation.fillMode = kCAFillModeForwards;
                groupAnimation.removedOnCompletion = NO;
                groupAnimation.animations = [NSArray arrayWithObjects:anim,anim1, nil];
                
                [tabBarItem.imageView.layer addAnimation:[CAAnimation HC_ScaleAnimation] forKey:@"groupAnimation"];
            }else if (animateType == HCConfigTabBarItemAnimateType_BoundsMin){
                [tabBarItem.imageView.layer addAnimation:[CAAnimation HC_TabBarBoundsMin] forKey:@"MinAnimation"];
            }else if (animateType == HCConfigTabBarItemAnimateType_BoundsMax){
                 [tabBarItem.imageView.layer addAnimation:[CAAnimation HC_TabBarBoundsMax] forKey:@"MaxAnimation"];
            }
            
            
        }else{ //非选中
            tabBarItem.titleLabel.textColor = tabBarConfig.normalTitleColor;
            tabBarItem.imageView.image = [UIImage imageNamed:self.normalImages[idx]];
            [tabBarItem.imageView.layer removeAllAnimations];
        }
        
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableArray *tempSubviewsArr = [NSMutableArray array];
    
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [view removeFromSuperview];
        }
        if([view isKindOfClass:[HCTabBarItem class]] || [view isKindOfClass:[UIButton class]]){
            [tempSubviewsArr addObject:view];
        }
    }
    
    //子控件进行排序
    for (UIView *view in tempSubviewsArr) {
        if([view isKindOfClass:[UIButton class]]){
            [tempSubviewsArr insertObject:view atIndex:view.tag];
            [tempSubviewsArr removeLastObject];
        }
    }
    
    //布局子控件
    CGFloat itemW = self.width / tempSubviewsArr.count;
    CGFloat itemH = kTabBarItemHeight;
    CGFloat itemY = 0;
    [tempSubviewsArr enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat itemX = idx * itemW;
        view.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)tabBarItems
{
    if(_tabBarItems) return _tabBarItems;
    _tabBarItems = [NSMutableArray array];
    return _tabBarItems;
}

@end
