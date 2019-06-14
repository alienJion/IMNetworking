//
//  MessageSendDeal.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageSendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageSendDeal : NSObject
@property (nonatomic,strong) MessageSendModel *sendModel;
+ (MessageSendDeal *)shareInstance;
/**
 获取配置将要发送的消息体
 */
-(NSData *)getSendMessageData;
@end

NS_ASSUME_NONNULL_END
