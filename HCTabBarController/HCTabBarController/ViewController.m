//
//  ViewController.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "HCTabBarConfig.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [[HCTabBarConfig sharedInstance] showNewBadgeAtIndex:1];
    
    [[HCTabBarConfig sharedInstance] showNumberBadge:@"12" atIndex:1];
}

@end
