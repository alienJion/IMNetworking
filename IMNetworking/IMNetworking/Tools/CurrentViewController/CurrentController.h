//
//  CurrentController.h
//  OAProject
//
//  Created by Alien on 2019/3/2.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrentController : NSObject
+ (instancetype)shareManager;
//获取当前屏幕显示的viewcontroller   利用递归
- (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
