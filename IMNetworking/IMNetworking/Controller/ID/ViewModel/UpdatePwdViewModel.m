//
//  UpdatePwdViewModel.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/25.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "UpdatePwdViewModel.h"//修改密码和忘记密码

@implementation UpdatePwdViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary*  _Nullable x) {
            [self.getCodeSubject sendNext:x];
            return ;
        }];
        [self.updatePwdCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary*  _Nullable x) {
            [self.updatePwdSubject sendNext:x];
            return ;
        }];
    }
    return self;
}


- (RACCommand *)getCodeCommand{
    if (_getCodeCommand == nil) {
        _getCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [SVProgressHUD XJshowHUD];
                [ServiceApi getCodeRequest:input success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
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
    return _getCodeCommand;
}
-(RACCommand *)updatePwdCommand{
    if (_updatePwdCommand == nil) {
        _updatePwdCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [SVProgressHUD XJshowHUD];
                [ServiceApi registerRequest:input success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
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
    return _updatePwdCommand;
}



-(RACSubject *)updatePwdSubject{
    if (_updatePwdSubject == nil) {
        _updatePwdSubject = [RACSubject subject];
    }
    return _updatePwdSubject;
}

-(RACSubject *)getCodeSubject{
    if (_getCodeSubject == nil) {
        _getCodeSubject = [RACSubject subject];
    }
    return _getCodeSubject;
}
@end
