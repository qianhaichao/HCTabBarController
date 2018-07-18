//
//  UIViewSimpleViewController.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/20.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "UIViewSimpleViewController.h"
#import "UIView+XMBorder.h"

@interface UIViewSimpleViewController ()

@end

@implementation UIViewSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupLeftBorder];

    [self setupBottomBorder];

    [self setupRightBorder];
}

#pragma mark - 创建左侧边框
- (void)setupLeftBorder
{
    UILabel *leftLbl = [XMControl createLabelWithFrame:CGRectMake(80, 100, 100, 30) font:13 text:@"左侧边框"];
//    leftLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftLbl];

    [leftLbl xm_addLeftBorderWithColor:[UIColor redColor] width:1.0 excludePoint:0 edgeType:XMExcludeAllPoint];
}

#pragma mark - 创建底部边框
- (void)setupBottomBorder
{
    UILabel *bottomLbl = [XMControl createLabelWithFrame:CGRectMake(80, 140, 100, 30) font:13 text:@"底部边框"];
//    bottomLbl.backgroundColor = [UIColor whiteColor];
    [bottomLbl xm_addBottomBorderWithColor:[UIColor redColor] width:1.0 excludePoint:0 edgeType:XMExcludeAllPoint];
    [self.view addSubview:bottomLbl];


}

#pragma mark - 设置右侧边框
- (void)setupRightBorder
{
    UITextField *textField = [XMControl createTextFieldWithFrame:CGRectMake(80, 180, 100, 30) placeholder:@"请输入用户名" leftImageView:nil font:13 textColor:[UIColor grayColor]];
    textField.backgroundColor = [UIColor greenColor];
    [textField xm_addRightBorderWithColor:[UIColor redColor] width:1.0];
    [self.view addSubview:textField];
}

@end
