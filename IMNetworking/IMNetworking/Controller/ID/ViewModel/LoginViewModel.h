//
//  LoginViewModel.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACSubject *loginSubject;
@end

NS_ASSUME_NONNULL_END
