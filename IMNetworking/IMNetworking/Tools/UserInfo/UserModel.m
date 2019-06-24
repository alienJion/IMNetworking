//
//  UserModel.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"userId":@"id",
             @"type":@[@"type",@"state"],
             };
}
@end
