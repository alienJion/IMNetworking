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
 首页查询
 */
+(void)queryHomeForType:(int)type
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**上传图片*/
+(void)uploadForImage:(NSString *)array
              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

/**绑定百度云推送 */
+(void)bindBaiduPush:(NSString *)pushuserid pushChannelId:(NSString *)pushchannelid
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//获取用户信息
+(void)getUserInfo:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//更新用户信息
+(void)updateUserInfo:(NSString *)username headimg:(NSString *)headimg sex:(NSString *)sex age:(NSString *)age success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//修改密码
+(void)changePwd:(NSString *)oldpwd newpwd:(NSString *)newpwd
         success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//查询消息列表
+(void)queryMessageList:(int)page success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;
//查询推送消息列表
+(void)queryPushMsg:(int)page success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//退出登录
+(void)loginOut:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//查询推送消息列表
+(void)queryChatSign:(NSString *)userId success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

+(void)uploadForVoice:(NSString *)path accData:(NSData *)aacData success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;
@end
