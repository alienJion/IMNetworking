//
//  ConfigIQKeyboard.m
//  Only
//
//  Created by Alien on 2018/6/7.
//  Copyright © 2018年 Alien. All rights reserved.
//

#import "ConfigIQKeyboard.h"
#import <IQKeyboardManager.h>
@implementation ConfigIQKeyboard
/**
 配置第三方键盘
 */
+(void)configIQKeyboard{
    IQKeyboardManager *IQManager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用
    IQManager.enable = YES;
    //控制点击背景是否收起键盘
    IQManager.shouldResignOnTouchOutside = YES;
    //控制是否显示键盘上的工具条
    IQManager.enableAutoToolbar = YES;
    
    //注意：以下设置只有enableAutoToolbar=YES时才有效果，且只会显示一个完成按钮
    IQManager.toolbarDoneBarButtonItemText = @"完成";
    //控制是否显示键盘上上下箭头
    IQManager.previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
    //是否显示占位文字
    IQManager.shouldShowToolbarPlaceholder = NO;
    //控制键盘上的工具条文字颜色是否用户自定义
    IQManager.shouldToolbarUsesTextFieldTintColor = NO;
    //控制键盘上的工具条文字颜色
//    IQManager.toolbarTintColor = DThemeColor;
    IQManager.toolbarTintColor = [UIColor blackColor];
}
@end
