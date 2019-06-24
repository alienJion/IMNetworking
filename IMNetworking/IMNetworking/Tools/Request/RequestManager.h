//
//  RequestManager.h
//  OAProject
//
//  Created by Alien on 2019/2/26.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestManager : NSObject
+(instancetype) sharedManager;
/**
 get 请求
 
 @param strUrl 请求地址
 @param success 成功block
 @param failure 失败block
 */
-(void)sendGetRequest:(NSString*)strUrl
              success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  delete请求
 *
 *  @param strUrl url
 */
-(void)sendDeleteRequest:(NSString*)strUrl
                 success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                 failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  post请求
 *
 *  @param parameter 请求需要的参数
 *  @param url 请求需要的url地址
 */
-(void)sendPostRequestParameter:(id)parameter andURl:(NSString *)url
                        success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                        failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  PUT请求
 *
 *  @param parameter 请求需要的参数
 *  @param url 请求需要的url地址
 */
-(void)sendPutRequestParameter:(id)parameter andURl:(NSString *)url
                       success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  PATC请求
 *
 *  @param parameter 请求需要的参数
 *  @param url 请求需要的url地址
 */
-(void)sendPATCHRequestParameter:(id)parameter andURl:(NSString *)url
                         success:(void (^)(NSURLSessionDataTask * task, id dataDic))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

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
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

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
            failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

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
             failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;




@end

NS_ASSUME_NONNULL_END
