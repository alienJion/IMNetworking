//
//  UIView+XJToast.h
//  OAProject
//
//  Created by Alien on 2019/2/26.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XJToast)
/**
 提示信息（1秒后消失）
 @param message 显示的内容
 */
- (void)XJShowToast:(NSString *)message;

/**
 图文提示（1秒后消失）
 @param message 文字
 @param imageName 图片
 */
- (void)XJShowWhiteToast:(NSString *)message imageName:(id)imageName;

/**
 图文提示（1秒后消失）
 @param message 文字
 @param imageName 图片
 */
- (void)XJShowBlackToast:(NSString *)message imageName:(id)imageName;
@end

NS_ASSUME_NONNULL_END
