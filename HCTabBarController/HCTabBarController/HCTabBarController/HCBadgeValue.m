//
//  HCBadgeValue.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "HCBadgeValue.h"
#import "CAAnimation+HCAnimation.h"
#import "UIView+HCFrame.h"
#import "HCTabBarConfig.h"

@implementation HCBadgeValue


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建徽标
        [self badgeLabel];
        
    }
    return self;
}

#pragma mark - setter方法
- (void)setBadgeType:(HCBadgeValueType)badgeType
{
    _badgeType = badgeType;
    
    if(badgeType == HCBadgeValueType_Point){ //点
        self.badgeLabel.size = CGSizeMake(10, 10);
        self.badgeLabel.layer.cornerRadius = 5.f;
        self.badgeLabel.x = 0;
        self.badgeLabel.y = (self.height - self.badgeLabel.size.height) * 0.5;
    }else if (badgeType == HCBadgeValueType_New){ //New
        self.badgeLabel.size = self.size;
    }else if (badgeType == HCBadgeValueType_Number){ //数字
        CGSize textSize = [self sizeWithText:self.badgeLabel.text];
        CGFloat badgeW = MIN(MAX(self.height, textSize.width + 5), self.width);
        self.badgeLabel.size = CGSizeMake(badgeW, self.height);
    }
    
    HCConfigBadgeValueAnimateType animateType = [HCTabBarConfig sharedInstance].badgeAnimateType;
    if(animateType == HCConfigBadgeValueAnimateType_Shake){ //抖动动画
        [self.badgeLabel.layer addAnimation:[CAAnimation HC_ShakeAnimation_RepeatTimes:5] forKey:@"ShakeAnimation"];
    }else if (animateType == HCConfigBadgeValueAnimateType_Opacity){ //透明度动画
        [self.badgeLabel.layer addAnimation:[CAAnimation HC_OpacityAnimation_DurationTime:0.3] forKey:@"OpacityAnimation"];
    }else if (animateType == HCConfigBadgeValueAnimateType_Scale){ //缩放动画
        [self.badgeLabel.layer addAnimation:[CAAnimation HC_ScaleAnimation] forKey:@"ScaleAnimation"];
    }
    
}

- (CGSize)sizeWithText:(NSString *)text
{
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.badgeLabel.font} context:nil].size;
}

#pragma mark - 懒加载
- (UILabel *)badgeLabel
{
    if(_badgeLabel) return _badgeLabel;
    _badgeLabel = [[UILabel alloc] init];
    _badgeLabel.textColor = [HCTabBarConfig sharedInstance].badgeTextColor;
    _badgeLabel.font = [UIFont systemFontOfSize:11.0f];
    _badgeLabel.backgroundColor = [HCTabBarConfig sharedInstance].badgeBgColor;
    _badgeLabel.layer.cornerRadius = 8.0f;
    _badgeLabel.layer.masksToBounds = YES;
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_badgeLabel];
    return _badgeLabel;
}

@end
