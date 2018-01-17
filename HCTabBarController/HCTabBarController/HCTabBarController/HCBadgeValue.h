//
//  HCBadgeValue.h
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HCBadgeValueType) {
    HCBadgeValueType_Point,
    HCBadgeValueType_New,
    HCBadgeValueType_Number,
};

@interface HCBadgeValue : UIView

//徽标
@property (nonatomic,strong) UILabel       *badgeLabel;
//徽标样式
@property (nonatomic,assign) HCBadgeValueType       badgeType;

@end
