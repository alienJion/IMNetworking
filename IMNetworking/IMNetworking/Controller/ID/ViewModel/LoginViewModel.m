//
//  LoginViewModel.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            NSDictionary *jsonDic = (NSDictionary *)x;
            [self.loginSubject sendNext:jsonDic];
            return ;
        }];
    }
    return self;
}
- (RACCommand *)loginCommand{
    if (_loginCommand == nil) {
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [SVProgressHUD XJshowHUD];
                [ServiceApi loginRequest:input success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                    [SVProgressHUD XJhideHUD];
                    XJLog(@"responseObject === %@",responseObject);
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     [SVProgressHUD XJhideHUD];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}
-(RACSubject *)loginSubject{
    if (_loginSubject == nil) {
        _loginSubject = [RACSubject subject];
    }
    return _loginSubject;
}
@end
