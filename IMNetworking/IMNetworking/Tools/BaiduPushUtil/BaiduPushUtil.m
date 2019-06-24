//
//  BaiduPushUtil.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/19.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "BaiduPushUtil.h"

@implementation BaiduPushUtil
+(void)bindBaiduYunPush{
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 绑定返回值
        
        UserModel *userModel=[[CacheUserInfo shareInstance] getCacheUserinfo];
        
        if (userModel!=nil&&result != nil && [[result objectForKey:@"error_code"] integerValue] == 0  ) {//绑定
            
            [ServiceApi bindBaiduPush:result[@"user_id"]  pushChannelId:result[@"channel_id"] success:^(NSURLSessionDataTask *task, id responseObject) {
                if([responseObject[@"ret"] intValue]==200){
                    NSLog(@"绑定成功");
                }else{
                    NSLog(@"绑定失败");
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"绑定失败");
            }];
         }
        else{
            NSLog(@"不绑定");
        }
        
    }];
}
+(void)unBindBaiduYunPush{
    [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 解绑返回值
       
    }];
}
@end
