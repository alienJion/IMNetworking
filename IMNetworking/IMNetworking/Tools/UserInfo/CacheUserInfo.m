//
//  CacheUserInfo.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "CacheUserInfo.h"

#define UserKey @"userInfo"
@interface CacheUserInfo()
@property(nonatomic,strong)YYCache *userCache;

@end

@implementation CacheUserInfo

//全局访问点
+ (CacheUserInfo *)shareInstance {
    static CacheUserInfo *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


/**
 保存用户信息

 @param model 用户model
 */
-(void)setCacheUserInfo:(UserModel *)model{
    [[self userCache] setObject:[model yy_modelToJSONString] forKey:UserKey];
}
/**
 获取用户信息

 @return 用户信息model
 */
-(UserModel *)getCacheUserinfo{
    NSString *modelStr = (NSString *)[[self userCache] objectForKey:UserKey];
    UserModel *model = [UserModel yy_modelWithJSON:modelStr];
    return model;
}
-(void)clearUserInfo{
    [self.userCache removeObjectForKey:UserKey];
}


-(YYCache *)userCache{
    if (_userCache == nil) {
        _userCache = [YYCache cacheWithName:UserKey];
    }
    return _userCache;
}
@end
