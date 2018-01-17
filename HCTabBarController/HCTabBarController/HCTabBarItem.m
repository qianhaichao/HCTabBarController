//
//  HCTabBarItem.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "HCTabBarItem.h"
#import "UIView+HCFrame.h"

@implementation HCTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建子控件
        [self setupSubviews];
    }
    return self;
}
/**
 * 创建子控件
 */
- (void)setupSubviews
{
    [self imageView];
    [self titleLabel];
    [self badgeValue];
}

#pragma mark - setter方法
- (void)setLayoutType:(HCConfigTabBarItemLayoutType)layoutType
{
    _layoutType = layoutType;
    
    if(layoutType == HCConfigTabBarItemLayoutType_Image){ //图片模式
        self.titleLabel.hidden = YES;
        CGSize imageSize = [HCTabBarConfig sharedInstance].imageSize;
        
        CGFloat imageX = (self.width - imageSize.width) * 0.5;
        CGFloat imageY = (self.height - imageSize.height) * 0.5;
        CGFloat imageW = imageSize.width;
        CGFloat imageH = imageSize.height;
        self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageSize = [HCTabBarConfig sharedInstance].imageSize;
    CGFloat imageY = 5;
    if(self.layoutType == HCConfigTabBarItemLayoutType_Image){
        imageY = (self.height - imageSize.height) * 0.5;
    }
    CGFloat imageX = (self.width - imageSize.width) * 0.5;
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleX = 4;
    CGFloat titleH = 14.f;
    CGFloat titleW = self.width - 8;
    CGFloat titleY = self.height - 14.f;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeH = 16;
    CGFloat badgeW = 30;
    self.badgeValue.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    
}


#pragma mark - 懒加载
- (UIImageView *)imageView
{
    if(_imageView) return _imageView;
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    return _imageView;
}
- (UILabel *)titleLabel
{
    if(_titleLabel) return _titleLabel;
    _titleLabel =  [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_titleLabel];
    return _titleLabel;
}
- (HCBadgeValue *)badgeValue
{
    if(_badgeValue) return _badgeValue;
    _badgeValue = [[HCBadgeValue alloc] init];
    _badgeValue.hidden = YES;
    [self addSubview:_badgeValue];
    return _badgeValue;
}

@end
