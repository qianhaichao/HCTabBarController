//
//  XMWebViewController.h
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMWebViewController : UIViewController

/** 标题 */
@property (nonatomic,copy)   NSString       *webTitle;

/** 进度条颜色 */
@property (nonatomic,strong) UIColor       *progressColor;


/**
 加载远程URL
 */
- (void)xm_loadRemoteURL:(NSString *)urlString;

/**
 加载本地html(默认是mainBundle)

 @param htmlName html文件名(注意需要带后缀名.html)
 */
- (void)xm_loadLocalHTML:(NSString *)htmlName;


/**
 加载指定bundle中的html

 @param htmlName html文件名(注意需要带后缀名.html)
 @param bundle 资源包
 */
- (void)xm_loadLocalHTML:(NSString *)htmlName inBundle:(NSBundle *)bundle;


/**
 *  设置状态栏statusBar样式
 *
 *  @param statusBarStyle  statusBar样式
 *  @param statusBarHidden 是否隐藏状态栏
 *  @param animated        动画效果
 */
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusBarHidden:(BOOL)statusBarHidden changeStatusBarAnimated:(BOOL)animated;



@end
