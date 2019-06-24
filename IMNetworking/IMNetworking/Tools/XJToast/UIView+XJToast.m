//
//  UIView+XJToast.m
//  OAProject
//
//  Created by Alien on 2019/2/26.
//  Copyright © 2019 ouwen. All rights reserved.
//

//记得倒入CurrentController

#import "UIView+XJToast.h"
#import "Toast.h"
//提示信息的显示时间（秒）
static float const ToastDuration = 1.0f;
static int   const ToastTag99991 = 99991;
@implementation UIView (XJToast)
- (void)XJShowToast:(NSString *)message{
    //添加透明背景View，防止多次点击
    UIView *bgView = [[CurrentController shareManager].getCurrentVC.view viewWithTag:ToastTag99991];
    if (!bgView) {
        bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgView.tag = ToastTag99991;
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [[CurrentController shareManager].getCurrentVC.view addSubview:bgView];
    }
    //样式一：黑色背景，白色字体
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont systemFontOfSize:15.0f];
    style.messageColor = [UIColor whiteColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    /*
     //样式二：白色背景，主题色字体
     CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
     style.messageFont = [UIFont systemFontOfSize:15.0f];
     style.messageColor = DThemeColor;
     style.messageAlignment = NSTextAlignmentCenter;
     style.backgroundColor = [UIColor whiteColor];
     */
    
    //是否同步执行多条提示信息
    [CSToastManager setQueueEnabled:NO];
    //当有点击手势的时候是否让提示信息消失
    [CSToastManager setTapToDismissEnabled:NO];
    [[CurrentController shareManager].getCurrentVC.view makeToast:message duration:ToastDuration position:CSToastPositionCenter title:nil image:nil style:style completion:^(BOOL didTap) {
        [bgView removeFromSuperview];
    }];
}

- (void)XJShowWhiteToast:(NSString *)message imageName:(id)imageName{
    //添加透明背景View，防止多次点击
    UIView *bgView = [[CurrentController shareManager].getCurrentVC.view viewWithTag:ToastTag99991];
    if (!bgView) {
        bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgView.tag = ToastTag99991;
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [[CurrentController shareManager].getCurrentVC.view addSubview:bgView];
    }
    //样式二：白色背景，主题色字体
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont systemFontOfSize:15.0f];
    style.messageColor = XJMainColor;
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [UIColor whiteColor];
    //图片大小
    style.imageSize = CGSizeMake(20, 20);
    //整个弹框的大小
    //style.activitySize = CGSizeMake(100, 100);
    //是否同步执行多条提示信息
    [CSToastManager setQueueEnabled:NO];
    //当有点击手势的时候是否让提示信息消失
    [CSToastManager setTapToDismissEnabled:NO];
    [[CurrentController shareManager].getCurrentVC.view makeToast:message duration:ToastDuration position:CSToastPositionCenter title:nil image:[UIImage imageNamed:imageName] style:style completion:^(BOOL didTap) {
        [bgView removeFromSuperview];
    }];
}

- (void)XJShowBlackToast:(NSString *)message imageName:(id)imageName{
    //添加透明背景View，防止多次点击
    UIView *bgView = [[CurrentController shareManager].getCurrentVC.view viewWithTag:ToastTag99991];
    if (!bgView) {
        bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgView.tag = ToastTag99991;
        bgView.backgroundColor = [UIColor clearColor];
        [[CurrentController shareManager].getCurrentVC.view addSubview:bgView];
    }
    //样式一：黑色背景，白色字体
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont systemFontOfSize:15.0f];
    style.messageColor = [UIColor whiteColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    //图片大小
    style.imageSize = CGSizeMake(20, 20);
    //整个弹框的大小
    //style.activitySize = CGSizeMake(100, 100);
    //是否同步执行多条提示信息
    [CSToastManager setQueueEnabled:NO];
    //当有点击手势的时候是否让提示信息消失
    [CSToastManager setTapToDismissEnabled:NO];
    [[CurrentController shareManager].getCurrentVC.view makeToast:message duration:ToastDuration position:CSToastPositionCenter title:nil image:[UIImage imageNamed:imageName] style:style completion:^(BOOL didTap) {
        [bgView removeFromSuperview];
    }];
}

@end

