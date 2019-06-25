//
//  UpdatePwdViewModel.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/25.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdatePwdViewModel : NSObject
@property (nonatomic, strong) RACCommand *getCodeCommand;
@property (nonatomic, strong) RACSubject *getCodeSubject;

@property (nonatomic, strong) RACCommand *updatePwdCommand;
@property (nonatomic, strong) RACSubject *updatePwdSubject;
@end

NS_ASSUME_NONNULL_END
