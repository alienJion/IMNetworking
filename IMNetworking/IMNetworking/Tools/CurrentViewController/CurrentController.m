//
//  CurrentController.m
//  OAProject
//
//  Created by Alien on 2019/3/2.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "CurrentController.h"

@implementation CurrentController
static CurrentController *currentController = nil;

+ (instancetype)shareManager{
    @synchronized(self){
        if (!currentController) {
            currentController = [[self alloc]init];
        }
        return currentController;
    }
}
//获取当前屏幕显示的viewcontroller   利用递归
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
