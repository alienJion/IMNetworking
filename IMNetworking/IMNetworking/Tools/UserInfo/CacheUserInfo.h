//
//  CacheUserInfo.h
//  Utilities
//
//  Created by 松涛王 on 2019/6/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CacheUserInfo : NSObject
//全局访问点
+ (CacheUserInfo *)shareInstance;



/**
 保存用户信息
 
 @param model 用户model
 */
-(void)setCacheUserInfo:(UserModel *)model;
/**
 获取用户信息
 
 @return 用户信息model
 */
-(UserModel *)getCacheUserinfo;



/**
 清除用户信息
 */
-(void)clearUserInfo;
@end

NS_ASSUME_NONNULL_END
