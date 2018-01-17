//
//  HCTabBarItem.h
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBadgeValue.h"
#import "HCTabBarConfig.h"

@interface HCTabBarItem : UIView

@property (nonatomic,strong) UIImageView       *imageView;
@property (nonatomic,strong) UILabel           *titleLabel;
@property (nonatomic,strong) HCBadgeValue       *badgeValue;

@property (nonatomic,assign) HCConfigTabBarItemLayoutType       layoutType;
@end
