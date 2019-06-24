//
//  RegisteViewModel.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisteViewModel : NSObject
@property (nonatomic, strong) RACCommand *getCodeCommand;
@property (nonatomic, strong) RACSubject *getCodeSubject;

@property (nonatomic, strong) RACCommand *registeCommand;
@property (nonatomic, strong) RACSubject *registeSubject;
@end

NS_ASSUME_NONNULL_END
