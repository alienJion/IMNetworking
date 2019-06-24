//
//  SVProgressHUD+DPHProgressHUD.h
//  Medical
//
//  Created by zhanglixiang on 2017/7/27.
//  Copyright © 2017年 duopuhui. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (DPHProgressHUD)
/**
 创建 loading View（可自定义显示样式）
 */
+(void)showDPHHUD;

/**
 移除 loading View
 */
+(void)hideDPHHUD;
@end
