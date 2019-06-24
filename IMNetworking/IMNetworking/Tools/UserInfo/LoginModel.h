//
//  LoginModel.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)UserModel *user;
@end

NS_ASSUME_NONNULL_END
