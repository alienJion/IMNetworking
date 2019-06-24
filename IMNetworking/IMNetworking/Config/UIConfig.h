//
//  UIConfig.h
//  Optimization
//
//  Created by Alien on 2018/4/20.
//  Copyright © 2018年 Alien. All rights reserved.
//

#ifndef UIConfig_h
#define UIConfig_h


#define PlaceholderImage [UIImage imageNamed:@"icon"]


// app的单例对象
#define YAppDelegate ((AppDelegate*)UIApplication.sharedApplication.delegate)
// 获取Window
#define YWindow [[UIApplication sharedApplication].windows lastObject]


// 屏幕宽度
#define YScreenWidth ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define YScreenHeight ([UIScreen mainScreen].bounds.size.height)
// 当前屏幕宽度和iphone 6上的比例
#define YScreenScale ([UIScreen mainScreen].bounds.size.width/375)
/// 状态栏高度
#define YStatusBarHeigh ([UIApplication sharedApplication].statusBarFrame.size.height)
/// 导航栏高度
#define YNavBarHeight 44.0

//是否是iPhoneX以上带有刘海机型
#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height > 736 ? YES : NO)

//头部高度
#define YTopNavHight (IS_IPHONE_X ? 88 : 64)
#define YTopStatusHeight (IS_IPHONE_X ? 44 : 20)
//底部危险区域高度
#define YBottomDangerArea (IS_IPHONE_X ? 34 : 0)
///tabbar高度
#define YTabBarHeight (IS_IPHONE_X ? 83 : 49)
//默认正方形图片
#define defaultImage [UIImage imageNamed:@"goods_default"]

// 弱引用的宏定义，避免强引用在block内的循环引用
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#pragma mark -  * * * * * * * * * * * * * * 主题 * * * * * * * * * * * * * *

//使用16进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 无色
#define YClearColor [UIColor clearColor]
// 白色
#define XJWhiteColor UIColorFromRGB(0Xffffff)

// 主题蓝色
#define XJMainColor UIColorFromRGB(0X4271C1)

//占位字体颜色
#define XJPlaceholderColor UIColorFromRGB(0XB5B5B5)

//灰色字体颜色
#define XJGrayColor UIColorFromRGB(0X787878)


// tabbarTitleColor
#define XJTabbarTitleColor UIColorFromRGB(0X272727)

// 背景
#define XJBgColor UIColorFromRGB(0Xf5f5f5)

// toolbar 标题颜色
#define XJToolbarTitleColor UIColorFromRGB(0Xffffff)









#pragma mark -  * * * * * * * * * * * * * * set Font * * * * * * * * * * * * * *

// 12号字体   辅助字体大小
#define YFontSize12 [UIFont fontWithName:@"Helvetica" size:12]

// 14号字体   内容字体大小
#define YFontSize14 [UIFont fontWithName:@"Helvetica" size:14]

// 16号字体   小标题字体大小
#define YFontSize16 [UIFont fontWithName:@"Helvetica" size:16]
// 18号字体   标题字体大小
#define YFontSize18 [UIFont fontWithName:@"Helvetica" size:18]
// 20号字体   标题字体大小
#define YFontSize20 [UIFont fontWithName:@"Helvetica" size:20]
// 22号字体   标题字体大小
#define YFontSize22 [UIFont fontWithName:@"Helvetica" size:22]
// 24号字体   标题字体大小
#define YFontSize24 [UIFont fontWithName:@"Helvetica" size:24]


#endif /* UIConfig_h */
