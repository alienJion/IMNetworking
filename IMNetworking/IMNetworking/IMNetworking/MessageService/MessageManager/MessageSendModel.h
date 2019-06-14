//
//  MessageSendModel.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgHeaderpbobjc.h"//消息头
NS_ASSUME_NONNULL_BEGIN

@interface MessageSendModel : NSObject
/**
 必须先设置bodyData
 */
@property(nonatomic,strong)NSData *bodyData;

@property (nonatomic,strong) Header *msgHeader;
@end

NS_ASSUME_NONNULL_END
