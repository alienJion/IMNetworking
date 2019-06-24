//
//  ServiceApi.m
//  express-iphone
//
//  Created by 松涛王 on 2017/2/22.
//  Copyright © 2017年 qikecn. All rights reserved.
//

#import "ServiceApi.h"
#import "AFNetworking.h"
#import "URLHeader.h"
#import "Common.h"
#import "RequestManager.h"
#define UserKey [NSString nullToString:[[CacheUserInfo shareInstance] getCacheUserinfo].key]
@implementation ServiceApi


/**
 登录
 */
+(void)loginRequest:(NSDictionary *)para
            success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    [[RequestManager sharedManager] sendPostRequestParameter:para andURl:LoginURL success:success failure:failure];
}

@end
