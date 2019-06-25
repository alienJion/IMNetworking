//
//  ServiceApi.h
//  express-iphone
//
//  Created by 松涛王 on 2017/2/22.
//  Copyright © 2017年 qikecn. All rights reserved.
//

#import "AFNetworking.h"
#import <Foundation/Foundation.h>

@interface ServiceApi : NSObject

/**
 登录
 */
+(void)loginRequest:(NSDictionary *)para
                  success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 获取验证码
 */
+(void)getCodeRequest:(NSDictionary *)para
            success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 注册
 */
+(void)registerRequest:(NSDictionary *)para
              success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 忘记密码和找回密码
 */
+(void)updatePwdRequest:(NSDictionary *)para
                success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
