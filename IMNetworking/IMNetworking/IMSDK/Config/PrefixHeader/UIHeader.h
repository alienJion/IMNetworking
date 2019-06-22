//
//  UIHeader.h
//  XJIM
//
//  Created by Alien on 2019/6/12.
//  Copyright © 2019 ouwen. All rights reserved.
//

#ifndef UIHeader_h
#define UIHeader_h
// 屏幕宽度
#define IMScreenWidth ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define IMScreenHeight ([UIScreen mainScreen].bounds.size.height)
// 当前屏幕宽度和iphone 6上的比例
#define IMScreenScale ([UIScreen mainScreen].bounds.size.width/375)
/// 状态栏高度
#define IMStatusBarHeigh ([UIApplication sharedApplication].statusBarFrame.size.height)
/// 导航栏高度
#define IMNavBarHeight 44.0

//是否是iPhoneX以上带有刘海机型
#define IMIS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height > 736 ? YES : NO)

//头部高度
#define IMTopNavHight (IMIS_IPHONE_X ? 88 : 64)
#define IMTopStatusHeight (IMIS_IPHONE_X ? 44 : 20)
//底部危险区域高度
#define IMBottomDangerArea (IMIS_IPHONE_X ? 34 : 0)
///tabbar高度
#define IMTabBarHeight (IMIS_IPHONE_X ? 83 : 49)

// 弱引用的宏定义，避免强引用在block内的循环引用
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;


//使用16进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* UIHeader_h */
