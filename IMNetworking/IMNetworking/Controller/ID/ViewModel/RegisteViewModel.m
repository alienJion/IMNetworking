//
//  RegisteViewModel.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "RegisteViewModel.h"

@implementation RegisteViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary*  _Nullable x) {
            [self.getCodeSubject sendNext:x];
            return ;
        }];
        [self.registeCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary*  _Nullable x) {
            [self.registeSubject sendNext:x];
            return ;
        }];
    }
    return self;
}


- (RACCommand *)getCodeCommand{
    if (_getCodeCommand == nil) {
        _getCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                [SVProgressHUD XJshowHUD];
//                [ServiceApi loginRequest:input success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//                    [SVProgressHUD XJhideHUD];
//                    XJLog(@"responseObject === %@",responseObject);
//                    [subscriber sendNext:responseObject];
//                    [subscriber sendCompleted];
//                } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                    [SVProgressHUD XJhideHUD];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _getCodeCommand;
}
-(RACCommand *)registeCommand{
    if (_registeCommand == nil) {
        _registeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               
                return nil;
            }];
        }];
    }
    return _registeCommand;
}



-(RACSubject *)registeSubject{
    if (_registeSubject == nil) {
        _registeSubject = [RACSubject subject];
    }
    return _registeSubject;
}

-(RACSubject *)getCodeSubject{
    if (_getCodeSubject == nil) {
        _getCodeSubject = [RACSubject subject];
    }
    return _getCodeSubject;
}
@end
