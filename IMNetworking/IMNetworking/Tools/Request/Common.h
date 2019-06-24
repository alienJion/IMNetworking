//
//  Common.h
//  express-iphone
//
//  Created by 松涛王 on 2017/2/22.
//  Copyright © 2017年 qikecn. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

#define UUID [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"]

#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   define DLog(fmt, ...) NSLog(@"DLog is close");
#else
#   define DLog(...)
#endif

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define VERSION @"0"

#define ALERT(title,mes) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alert show];
#define ALERT_TOW(title,mes,btnTxt) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:mes delegate:nil cancelButtonTitle:btnTxt otherButtonTitles:nil, nil];[alert show];

#define SHOW_NETWORK_FAILURE ALERT(@"提示", @"网络请求失败")

#define TOAST(msg) [MBProgressHUD showToast:msg]
#define TOAST_ERROR(msg) [MBProgressHUD showError:msg]
#define TOAST_SUCCESS(msg) [MBProgressHUD showSuccess:msg]
#define TOAST_NETWORK_FAILURE [MBProgressHUD showError:@"网络请求失败"]

#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height


#define BAIDUYUN_KEY @""
#define IMAPP_ID @"1400186325"



//程序配置开始--配置在两个地方，Urls.plist为网址相关配置，其他配置在下面
//程序主色调 20438d
#define MAIN_COLOR RGBCOLOR(0x20, 0x43, 0x8d)
#define PRICE_COLOR RGBCOLOR(0xd8, 0x1e, 0x06)
#define BG_COLOR RGBCOLOR(0xf5, 0xf5, 0xf5)
#define APP_NAME_DEFAULT @"IM"
#define zongji @"10000"
#define umeng_channel @"qikecn"
//copyright launchScreen也需要修改，不在此处
#define copyright @"COPYRIGHT © 2019 IM ALL RIGHTS RESERVED"

//程序配置结束

#define font_size_smaller 12
#define font_size_small 14
#define font_size_middle 16
#define font_size_large 18
#define font_size_larger 22

#endif /* Common_h */
