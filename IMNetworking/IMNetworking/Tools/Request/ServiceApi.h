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
+(void)loginRequest:(NSDictionary *)pram
                  success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
