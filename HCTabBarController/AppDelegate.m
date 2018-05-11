//
//  AppDelegate.m
//  HCTabBarController
//
//  Created by 钱海超 on 2018/1/17.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "HCTabBarController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //初始化标题数组, 未选择图片数组, 选择图片数组, 控制器数组
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"首页",@"声音",@"下载",@"我的", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"tabBar_essence_icon",@"tabBar_me_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"tabBar_essence_click_icon",@"tabBar_me_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon", nil];
    
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        ViewController *vc = [[ViewController alloc] init];
        vc.title = titleArr[i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
    }
    HCTabBarConfig *tabBarConfig = [HCTabBarConfig sharedInstance];
    tabBarConfig.tabBarItemAnimateType = HCConfigTabBarItemAnimateType_RotationY;
    tabBarConfig.badgeAnimateType = HCConfigBadgeValueAnimateType_Scale;
    
    HCTabBarController *tabBarVC = [[HCTabBarController alloc] initWithViewControllers:controllers normalImages:imageNormalArr selectedImages:imageSelectedArr titles:titleArr tabBarConfig:tabBarConfig];
    
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
    [btn setImage:[UIImage imageNamed:@"VIP"] forState:UIControlStateNormal];
    [tabBarConfig addCustomTabBarItem:btn adIndex:2 itemClickBlock:^(UIButton *customItem, NSInteger index) {
        NSLog(@"*******点击了中间按钮********");
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor orangeColor];
        [[HCTabBarConfig sharedInstance].tabBarController presentViewController:vc animated:YES completion:nil];
        
        //测试代码 (两秒后自动关闭)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:nil];
        });
        
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
