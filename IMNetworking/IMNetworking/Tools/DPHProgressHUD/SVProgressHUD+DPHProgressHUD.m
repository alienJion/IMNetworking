//
//  SVProgressHUD+DPHProgressHUD.m
//  Medical
//
//  Created by zhanglixiang on 2017/7/27.
//  Copyright © 2017年 duopuhui. All rights reserved.
//

#import "SVProgressHUD+DPHProgressHUD.h"

@implementation SVProgressHUD (DPHProgressHUD)

+(void)showDPHHUD{
    //动画类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    //蒙版效果
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    //设置自定义样式（当设置为SVProgressHUDStyleCustom时，自定义样式才会有效）
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD show];
}

+(void)hideDPHHUD{
    [SVProgressHUD dismiss];
}

@end
