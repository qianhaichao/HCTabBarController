//
//  UIWebViewSimpleViewController.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "UIWebViewSimpleViewController.h"
#import "XMWebViewController.h"

@interface UIWebViewSimpleViewController ()

@end

@implementation UIWebViewSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载html
    [self xm_loadLocalHTML:@"contract.html"];
}

@end
