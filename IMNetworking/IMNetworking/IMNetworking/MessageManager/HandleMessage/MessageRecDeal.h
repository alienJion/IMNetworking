//
//  MessageRecDeal.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketManager.h"
#import "MessageHeader.h"
#import "MsgProtobufHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageRecDeal : NSObject
+ (MessageRecDeal *)shareInstance;
/**
 接收消息处理

 @param pBuffer 长链接接收到的消息
 */
- (void)handleRecvData:(NSData*)pBuffer;
@property (nonatomic,strong) RACSubject *dataSubject;
@end

NS_ASSUME_NONNULL_END
