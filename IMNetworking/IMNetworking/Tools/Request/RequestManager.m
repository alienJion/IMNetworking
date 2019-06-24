//
//  RequestManager.m
//  OAProject
//
//  Created by Alien on 2019/2/26.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "RequestManager.h"


static float const requestTime = 30.0f;
@interface RequestManager()
/**
 存放请求头中要存放的字段
 */
@property(nonatomic,strong)NSDictionary *headerDic;
@property(nonatomic,strong)AFHTTPSessionManager *sessionManager;

@end
@implementation RequestManager
static RequestManager * _requestManager = nil;
+(instancetype) sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _requestManager= [[self alloc] init];
    });
    return _requestManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
-(AFHTTPSessionManager *)sessionManager{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc]init];
        //    设置请求数据为json对象
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];

        
        // 设置返回数据为json数据
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 设置返回数据为原始数据
        //        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 安全策略
        _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sessionManager.securityPolicy.allowInvalidCertificates = NO;
        [_sessionManager.securityPolicy setValidatesDomainName:YES];
        [_sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        // 请求时长
        _sessionManager.requestSerializer.timeoutInterval = requestTime;
    }
    if(UserToken.length != 0){
        NSString *token = [NSString stringWithFormat:@"%@",UserToken];
        XJLog(@"\ntoken =====   %@\n",token);
        [_sessionManager.requestSerializer setValue:UserToken forHTTPHeaderField:@"token"];
    }
    return _sessionManager;
}
/**
 get 请求
 
 @param strUrl 请求地址
 @param success 成功block
 @param failure 失败block
 */
-(void)sendGetRequest:(NSString*)strUrl
              success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    strUrl = [self getDetailedUrl:strUrl];
    XJLog(@"strUrl===%@",strUrl);
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self.sessionManager GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",strUrl,(long)response.statusCode);

        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {//返回yes中断请求
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  delete请求
 *
 *  @param strUrl url
 */
-(void)sendDeleteRequest:(NSString*)strUrl
                 success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                 failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    strUrl = [self getDetailedUrl:strUrl];
    XJLog(@"strUrl===%@",strUrl);
    // 判断网络请求中是否包含中文或者空格转码
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    XJLog(@"strUrl===%@",strUrl);
    [self.sessionManager DELETE:strUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",strUrl,(long)response.statusCode);
        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  post请求
 *
 *  @param parameter 请求需要的参数
 *  @param url 请求需要的url地址
 */
-(void)sendPostRequestParameter:(id)parameter andURl:(NSString *)url
                        success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                        failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    url = [self getDetailedUrl:url];
    XJLog(@"post请求的Url===%@,\n请求参数：%@",url,parameter);
    self.headerDic = [[NSDictionary alloc]initWithDictionary:parameter];
    // 判断网络请求中是否包含中文或者空格转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self.sessionManager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",url,(long)response.statusCode);
        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  PUT请求
 *
 *  @param parameter 请求需要的参数
 *  @param url 请求需要的url地址
 */
-(void)sendPutRequestParameter:(id)parameter andURl:(NSString *)url
                       success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    url = [self getDetailedUrl:url];
    XJLog(@"PUT请求的Url===%@,\n请求参数：%@",url,parameter);
    // 判断网络请求中是否包含中文或者空格转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [self.sessionManager PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",url,(long)response.statusCode);
        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  PATC请求
 *
 *  @param parameter 请求需要的参数
 *  @param url 请求需要的url地址
 */
-(void)sendPATCHRequestParameter:(id)parameter andURl:(NSString *)url
                         success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    url = [self getDetailedUrl:url];
    XJLog(@"PATCH请求的Url===%@,\n请求参数：%@",url,parameter);
    // 判断网络请求中是否包含中文或者空格转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self.sessionManager PATCH:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",url,(long)response.statusCode);
        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  单独上传图片
 *
 *  @param image 图片
 *  @param key   key
 *  @param url   上传图片地址
 */
- (void)uploadImage:(UIImage*)image
        andImageKey:(NSString *)key
             andUrl:(NSString *)url
            success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    url = [self getDetailedUrl:url];
    // 判断网络请求中是否包含中文或者空格转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self.sessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        if (imageData.length/1000 > 4000) {
            imageData =  UIImageJPEGRepresentation(image, 3500/(imageData.length/1000));
        }
        
        [formData appendPartWithFileData:imageData name:key fileName:[self imageName] mimeType:@"image/jpeg"];
        
    } progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  上传图片与参数一起发送
 *
 *  @param image       图片名称
 *  @param key 图片对应的key
 *  @param editingInfo 请求需要的参数的字典集合
 */
- (void)uploadImage:(UIImage*)image andImageKey:(NSString *)key
        editingInfo:(NSDictionary*)editingInfo
            success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    NSString *url = [NSString stringWithFormat:@"%@",[editingInfo objectForKey:@"requestURL"]];
    XJLog(@"put请求的原始Url===%@",url);
    NSMutableDictionary* temp = [NSMutableDictionary dictionaryWithDictionary:editingInfo];
    XJLog(@"%@",temp);
    [temp removeObjectForKey:@"requestURL"];
    // 判断网络请求中是否包含中文或者空格转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    XJLog(@"strUrl===%@",url);
    [self.sessionManager POST:url parameters:temp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        if (imageData.length/1000 > 4000) {
            imageData =  UIImageJPEGRepresentation(image, 3500/(imageData.length/1000));
        }
        
        [formData appendPartWithFileData:imageData name:@"photos" fileName:[self imageName] mimeType:@"image/jpeg"];
        
    } progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",url,(long)response.statusCode);
        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}

/**
 *  上传多张图片
 *
 *  @param images 图片
 *  @param key   key
 *  @param url   上传图片地址
 */
- (void)uploadImages:(NSArray *)images
        andImagesKey:(NSString *)key
              andUrl:(NSString *)url
             success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
             failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    url = [self getDetailedUrl:url];
    // 判断网络请求中是否包含中文或者空格转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    [self.sessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传 多张图片
        for (UIImage *image in images) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            if (imageData.length/1000 > 4000) {
                imageData =  UIImageJPEGRepresentation(image, 3500/(imageData.length/1000));
            }
            // 上传图片，以文件流的格式
            [formData appendPartWithFileData:imageData name:key fileName:[self imageName] mimeType:@"image/jpeg"];
        }
        
    } progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //先拿到http的code
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        XJLog(@"接口：%@,对应的httpCode:%ld",url,(long)response.statusCode);
        [responseObject yy_modelToJSONObject];
        NSDictionary *dataDic = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDic = responseObject;
            if ([self isInterruptRequest:dataDic]) {
                if (failure) {
                    NSError * _Nonnull error;
                    failure(task,error);
                }
            }else{
                if (success) {
                    success(task,dataDic);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XJLog(@"上传图片:%@",error);
        [self requestFailure:task error:error];
        if (failure) {
            failure(task,error);
        }
    }];
}


/**
 配置上穿图片名称
 @return 返回图片名称
 */
-(NSString *)imageName{
    // 上传文件
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    return fileName;
}
//请求失败的错误信息处理
-(void)requestFailure:(NSURLSessionDataTask *)task error:(NSError *)error
{
    NSDictionary *errorDic;
    // 拿到AFHTTPRequestOperation中的responseObject（服务器返回的信息）
    id errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSString *stringCode = [[NSString alloc]initWithFormat:@"%ld",(long)response.statusCode];
    XJLog(@"请求失败的错误信息：%@\n错误代码:%d",errorDic,[stringCode intValue]);
    if (errorData != NULL) {
        XJLog(@"%@",errorData);
        errorDic = [Utilitles dictionaryWithJsonData:errorData];
    }
    if (errorDic.count > 0 || [stringCode isEqualToString:@"401"]) {
        [YWindow XJShowToast:errorDic[@"message"]];
    }else{
        [YWindow XJShowToast:@"网络异常，请稍后重试"];
    }
}
/**
 是否中断请求   YES。中断。  code封住
 
 @return 是否正常
 */
-(BOOL)isInterruptRequest:(NSDictionary *)dataDic{
    XJLog(@"请求返回数据：%@",dataDic);
    if ([[NSString stringWithFormat:@"%@",dataDic[@"code"]] isEqualToString:@"1"]) {
        return NO;
    }
    if([NSString stringWithFormat:@"%@",dataDic[@"msg"]].length > 0){
        [YWindow XJShowToast:dataDic[@"msg"]];
        return YES;
    }
    [YWindow XJShowToast:@"网络异常"];
    return YES;
}
-(NSString *)getDetailedUrl:(NSString *)url{
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        return url;
    }
    return [NSString stringWithFormat:@"%@%@",BaseURL,url];
}

@end
