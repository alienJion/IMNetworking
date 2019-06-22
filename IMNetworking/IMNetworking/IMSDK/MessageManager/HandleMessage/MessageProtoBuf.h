//
//  MessageProtoBuf.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageProtoBuf : NSObject
/**
 将要发送的消息进行处理

 @param bodyData bodyData
 @param headerData headerData
 @return data
 */
+(NSData *)builderProtoBufMessage:(NSData *)bodyData HeaderData:(NSData *)headerData;
@end

NS_ASSUME_NONNULL_END
