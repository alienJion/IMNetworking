//
//  PacketService.h
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PacketService : NSObject
+ (PacketService *)shareInstance;
// 发送数据包
- (void)sendPacket:(NSData *)packet;
// 读取消息包
- (void)readPacket;
@end

NS_ASSUME_NONNULL_END
