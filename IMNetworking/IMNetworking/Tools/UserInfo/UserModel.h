//
//  UserModel.h
//  Utilities
//
//  Created by 松涛王 on 2019/6/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
/**
 用户id
 */
@property(nonatomic,strong)NSString *appKey;
/**
 公司
 */
@property(nonatomic,strong)NSString *company;
/**
 部门
 */
@property(nonatomic,strong)NSString *depName;
/**
 头像缩略图
 */
@property(nonatomic,strong)NSString *imgThumbnailUrl;
/**
 头像
 */
@property(nonatomic,strong)NSString *imgUrl;
/**
 工号
 */
@property(nonatomic,strong)NSString *jobNo;
/**
 昵称
 */
@property(nonatomic,strong)NSString *nickName;
/**
 手机号
 */
@property(nonatomic,strong)NSString *phone;
/**
 用户id
 */
@property(nonatomic,strong)NSString *userId;
/**
 用户名称
 */
@property(nonatomic,strong)NSString *userName;

@end

NS_ASSUME_NONNULL_END
