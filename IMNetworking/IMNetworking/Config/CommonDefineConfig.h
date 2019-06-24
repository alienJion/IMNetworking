//
//  CommonDefineConfig.h
//  Optimization
//
//  Created by Alien on 2018/5/10.
//  Copyright © 2018年 YA. All rights reserved.
//

#ifndef CommonDefineConfig_h
#define CommonDefineConfig_h

/**高德地图key*/
#define MapKey @"292a96cf204ec99e7739e7a5d9bfd70f"

#define UmengAppkey @"5a0d6a34b27b0a4fd0000092"

#define UserToken [[CacheUserInfo shareInstance] getCacheToken]


// app的单例对象
#define YAppDelegate ((AppDelegate*)UIApplication.sharedApplication.delegate)
// 获取Window
#define YWindow [[UIApplication sharedApplication].windows lastObject]
// 版本号 CFBundleShortVersionString
#define YVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
// 当前系统版本号
#define YSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

#define YheadPlaceholderImage [UIImage imageNamed:@"feedback_avatar"]
#define YProductPlaceholderImage [UIImage imageNamed:@"goods_placeholder"]
//字符串转化url
#define STRING_URL(str)        [NSURL URLWithString:str]

#endif /* CommonDefineConfig_h */
