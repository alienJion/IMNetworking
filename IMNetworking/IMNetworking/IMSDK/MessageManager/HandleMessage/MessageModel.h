//
//  MessageModel.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgHeaderpbobjc.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property(nonatomic,strong)NSData *msgBodyData;
@property (nonatomic,copy)Header  *msgHeader;
@end

NS_ASSUME_NONNULL_END
