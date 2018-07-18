//
//  NSStringSimpleViewController.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "NSStringSimpleViewController.h"
#import "NSString+XMAttributeString.h"

@interface NSStringSimpleViewController ()

@end

@implementation NSStringSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //样式一
    [self setupAttributeStyle1];

    //样式二
    [self setupAttributeStyle2];

    //样式三
    [self setupAttributeStyle3];

    //样式四
    [self setupAttributeStyle4];

    //样式五
    [self setupAttributeStyle5];
}

#pragma mark - 样式一
- (void)setupAttributeStyle1
{
    UILabel *lbl = [XMControl createLabelWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 30) font:13 text:@"我想我们都一样，渴望梦想的光芒，张杰"];
    lbl.textColor = [UIColor greenColor];
    lbl.attributedText = [lbl.text xm_attributeStringWithTextColor:[UIColor redColor] attrString:@"我" type:XMAttributeStringTypeSelected];
    [self.view addSubview:lbl];
}

#pragma mark - 样式二
- (void)setupAttributeStyle2
{
    UILabel *lbl = [XMControl createLabelWithFrame:CGRectMake(10, 140, kScreenWidth - 20, 30) font:13 text:@"我想我们都一样，渴望梦想的光芒，张杰"];
    lbl.attributedText = [lbl.text xm_attributeStringWithTextColor:[UIColor redColor] range:NSMakeRange(3, 4) type:XMAttributeStringTypeSelected];
    [self.view addSubview:lbl];
}

#pragma mark - 样式三
- (void)setupAttributeStyle3
{
    UILabel *lbl = [XMControl createLabelWithFrame:CGRectMake(10, 180, kScreenWidth - 20, 30) font:13 text:@"我想我们都一样，渴望梦想的光芒，张杰"];
    lbl.attributedText = [lbl.text xm_attributeStringWithTextColor:[UIColor redColor] attrStringArr:@[@"我想",@"梦想"] type:XMAttributeStringTypeSelected];
    [self.view addSubview:lbl];
}

#pragma mark - 样式四
- (void)setupAttributeStyle4
{
    UILabel *lbl = [XMControl createLabelWithFrame:CGRectMake(10, 220, kScreenWidth - 20, 30) font:13 text:@"我想我们都一样，渴望梦想的光芒，张杰"];
    lbl.attributedText = [lbl.text xm_attributeStringWithTextColor:[UIColor redColor] font:[UIFont systemFontOfSize:20] attrString:@"梦想" type:XMAttributeStringTypeSelected];
    [self.view addSubview:lbl];
}
#pragma mark - 样式五
- (void)setupAttributeStyle5
{
    UILabel *lbl = [XMControl createLabelWithFrame:CGRectMake(10, 260, kScreenWidth - 20, 40) font:13 text:@"我想我们都一样，渴望梦想的光芒，一直在无星夜空,守护着我们的梦，这世界那么大，我的爱只想要你懂，陪伴我孤寂旅程"];
    lbl.numberOfLines = 0;
    lbl.attributedText = [lbl.text xm_attributeStringWitLineSpace:3 textSpace:5];
    [self.view addSubview:lbl];
}
@end
