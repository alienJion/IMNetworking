//
//  MainTabBarConfig.m
//  Only
//
//  Created by Alien on 2018/6/7.
//  Copyright © 2018年 Alien. All rights reserved.
//

#import "MainTabBarConfig.h"
#import "HomeViewController.h"
#import "AddressBookViewController.h"
#import "PersionViewController.h"

@implementation MainTabBarConfig
/**
 设置TabBarController
 */
+(MainTabBarController*)setMainTabBarController{
    MainTabBarController *mainTabbarVC = [[MainTabBarController alloc]init];
    NSArray *VCS = @[
                     [HomeViewController new],
                     [AddressBookViewController new],
                     [PersionViewController new]
                     ];
    NSArray *VCTitles = @[
                          @"消息",
                          @"通讯录",
                          @"设置",
                          ];
    NSArray *tabBarDefaultImages = @[
                                     @"msg_n",
                                     @"book_n",
                                     @"seting_n",
                                     ];
    NSArray *tabbarSelectedImages = @[
                                      @"msg_y",
                                      @"book_y",
                                      @"seting_y",
                                      ];
    [mainTabbarVC setViewControllers:VCS viewControllerTitleS:VCTitles defaultImages:tabBarDefaultImages selectedImages:tabbarSelectedImages];
    mainTabbarVC.selectedIndex = 0;
    return mainTabbarVC;
}
@end
