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
//#import "NSString+encrypto.h"
//#import "Base64Util.h"
//#import "RandomUtil.h"
//#import "UserDefaultsUtil.h"
//#import "AccountManager.h"
#import "Common.h"

#define UserKey [NSString nullToString:[[CacheUserInfo shareInstance] getCacheUserinfo].key]
@implementation ServiceApi

/**首页接口*/
+(void)queryHomeForType:(int)type
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //读取接口地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,QueryHome];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    XJLog(@"UserKey%@",UserKey);
    
    
    [dict setObject:[NSString nullToString:UserKey] forKey:@"key"];
    [dict setObject:[NSString nullToString:zongji] forKey:@"zongji"];
    [dict setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
    
}
/**上传图片*/
/*
 * array:[{"localFilePath":"","base64Data":""},{"localFilePath":"","base64Data":""}]
 */
+(void)uploadForImage:(NSString *)array
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    //读取接口地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,UploadPic];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:array forKey:@"array"];
    //3.请求
    [manager POST:url parameters:dict progress:nil success:success failure:failure];


}
//绑定百度推送
+(void)bindBaiduPush:(NSString *)pushuserid pushChannelId:(NSString *)pushchannelid success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    //请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,BindBaiDuPush];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    [dict setObject:pushuserid forKey:@"pushuserid"];
    [dict setObject:pushchannelid forKey:@"pushchannelid"];
    //3.请求
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}
//获取用户信息
+(void)getUserInfo:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    //请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,GetUserInfo];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    //3.请求
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}
//更新用户信息
+(void)updateUserInfo:(NSString *)username headimg:(NSString *)headimg sex:(NSString *)sex age:(NSString *)age success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    //请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,UpdateUserInfo];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSLog(@"UserKey%@",UserKey);
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    [dict setObject:username forKey:@"username"];
    [dict setObject:headimg forKey:@"headimg"];
    
    [dict setObject:sex forKey:@"sex"];
    
    
    [dict setObject:age  forKey:@"age"];
    
    
    //3.请求
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}
//修改密码
+(void)changePwd:(NSString *)oldpwd newpwd:(NSString *)newpwd success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    //请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,ChangePwd];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
//旧密码需要MD5
    [dict setObject:[oldpwd md5] forKey:@"oldpwd"];
    [dict setObject:newpwd forKey:@"newpwd"];
    //3.请求
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}

//获取消息列表
+(void)queryMessageList:(int)page success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    //读取接口地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,QueryMessage];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
    
}
//查询推送消息
+(void)queryPushMsg:(int)page success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    //读取接口地址
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,QueryPushMsgList];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
    
}
//退出登录
+(void)loginOut:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,QueryPushMsgList];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}

+(void)queryChatSign:(NSString *)userId success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,QueryChatSign];
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:UserKey forKey:@"key"];
    [dict setObject:zongji forKey:@"zongji"];
    [dict setObject:userId forKey:@"userid"];
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}

+(void)uploadForVoice:(NSString *)path accData:(NSData *) aacData success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,UploadVideo];//上传音频地址
    //1.管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.参数
    NSString *base64Data = [[NSString alloc]initWithData:[aacData base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];

    NSLog(@"base64Data:%@",base64Data);
    NSMutableDictionary *dic= [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setValue:path forKey:@"localFilePath"];
    [dic setValue:base64Data forKey:@"base64Data"];
    
    //将数据转化为json数组 然后 array=json数组字符串 然后NSData上传
    NSString *jsonString = [dic yy_modelToJSONString];
    NSArray *jsonArray = @[jsonString];
    
    NSString *upString = [NSString stringWithFormat:@"array=%@",[jsonArray yy_modelToJSONString]];
    NSLog(@"%@",upString);
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[upString dataUsingEncoding:NSUTF8StringEncoding] name:@"data"];
    } progress:nil success:success failure:failure];

}

- (NSString *)encode:(NSString *)string
{
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return baseString;
}

@end
