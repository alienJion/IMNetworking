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
@property(nonatomic,strong)NSString *userId;
/**
 用户id
 */
@property(nonatomic,strong)NSString *key;
/**
 用户类型 0:普通用户 1:快递员用户
 */
@property(nonatomic,strong)NSString *type;
/**
 用户名称
 */
@property(nonatomic,strong)NSString *username;
/**
 用户id
 */
@property(nonatomic,strong)NSString *phone;
/**
 用户头像
 */
@property(nonatomic,strong)NSString *headimg;

@property(nonatomic,strong)NSString *sex;

@property(nonatomic,strong)NSString *age;

@property(nonatomic,strong)NSString *money;//余额


@end

NS_ASSUME_NONNULL_END
