//
//  LoginModel.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"user" : [UserModel class],
             };
}
@end
