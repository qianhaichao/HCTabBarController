//
//  XMWebViewController.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "XMWebViewController.h"
#import "XMWebProgressLayer.h"

@interface XMWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView                *webView;
@property (nonatomic,strong) XMWebProgressLayer       *progressLayer;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@end

@implementation XMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //UI布局
    [self layoutUI];

    //导航条设置
    [self layoutNavigationBar];
}

#pragma mark - UI布局
- (void)layoutUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.webTitle;
    self.statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 导航条设置
- (void)layoutNavigationBar
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 14, 28);
    [backBtn setTitle:@"<-" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma mark - 外部调用方法
/**
 加载远程URL
 */
- (void)xm_loadRemoteURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

/**
 加载本地html(默认是mainBundle)

 @param htmlName html文件名
 */
- (void)xm_loadLocalHTML:(NSString *)htmlName
{
    [self xm_loadLocalHTML:htmlName inBundle:[NSBundle mainBundle]];
}


/**
 加载指定bundle中的html

 @param htmlName html文件名
 @param bundle 资源包
 */
- (void)xm_loadLocalHTML:(NSString *)htmlName inBundle:(NSBundle *)bundle
{
    NSString *filepath = [bundle pathForResource:htmlName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filepath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - 设置系统状态栏样式
/**
 *  设置状态栏statusBar样式
 *
 *  @param statusBarStyle  statusBar样式
 *  @param statusBarHidden 是否隐藏状态栏
 *  @param animated        动画效果
 */
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusBarHidden:(BOOL)statusBarHidden changeStatusBarAnimated:(BOOL)animated
{

    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }

}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden {

    return self.statusBarHidden;
}

#pragma mark - 事件监听

/**
 返回按钮点击事件
 */
- (void)backButton:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
    //移除涂层
    [self.progressLayer removeFromSuperlayer];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {

    [self.progressLayer xm_startLoad];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self.progressLayer xm_finishedLoadWithError:nil];
    self.title = self.webTitle ? self.webTitle : [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    [self.progressLayer xm_finishedLoadWithError:error];

}

- (void)dealloc {
    [_progressLayer xm_closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

#pragma mark - 懒加载
- (UIWebView *)webView
{
    if(_webView) return _webView;
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.translatesAutoresizingMaskIntoConstraints = NO; //注意必须写上这句话
    _webView.delegate =self;
    [self.view addSubview:_webView];

    //_webView左侧与父视图左侧对齐
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];

    //_webView右侧与父视图右侧对齐
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];

    //_webView顶部与父视图顶部对齐
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];

    //_webView低部与父视图低部对齐
    NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];

    //iOS 8.0以后设置active属性值
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
    bottomConstraint.active = YES;

    return _webView;
}
- (XMWebProgressLayer *)progressLayer
{
    if(_progressLayer) return _progressLayer;
    _progressLayer = [[XMWebProgressLayer alloc] init];
    _progressLayer.frame = CGRectMake(0, 42, [UIScreen mainScreen].bounds.size.width, 2);
    _progressLayer.strokeColor = self.progressColor ? self.progressColor.CGColor : [UIColor blueColor].CGColor;
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    return _progressLayer;
}

@end
