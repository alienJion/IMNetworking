//
//  ConfigGlobalStyle.m
//  Only
//
//  Created by Alien on 2018/6/7.
//  Copyright © 2018年 Alien. All rights reserved.
//

#import "ConfigGlobalStyle.h"

@implementation ConfigGlobalStyle
/**
 配置tabbar和navigation全局样式
 */
+ (void)configGlobalStyle{
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [UINavigationBar appearance].translucent = NO;
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 9.0f){
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:mainColor,NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:18]}];
    }

    [[UINavigationBar appearance]setTintColor:mainColor];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.3f]} forState:UIControlStateNormal];
    [UITabBar appearance].translucent  = NO;
    [UITabBar appearance].backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    [UITabBar appearance].tintColor = mainColor;
    if (@available(iOS 10.0, *)) {
        [UITabBar appearance].unselectedItemTintColor = titleColor;
    } else {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor} forState:UIControlStateNormal];
    }
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"system_back"];
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"system_back"];
}
@end
