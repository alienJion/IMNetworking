//
//  SendMessage.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgChatpbobjc.h"
#import "MsgHeaderpbobjc.h"
#import "BuilderMessage.h"
#import "MessageProtoBuf.h"

#import "SocketManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface SendMessage : NSObject
/**
 发送文本消息 (包含自带图标)
 
 @param content 消息内容
 @param senderUid 发送方id
 @param receiverUid 接收方id
 @param chatType 聊天类型
 */
+(void)sendChatTextMsg:(NSString *)content
                         SenderUid:(int64_t)senderUid
                       ReceiverUid:(int64_t)receiverUid
                          ChatType:(Header_ChatMsgType)chatType;
/**
 构建图片消息
 
 @param originalURL 原图
 @param thumbURL 缩略图
 @param senderUid 发送方
 @param receiverUid 接收方
 */
+(void)sendChatImageMsg:(NSString *)originalURL
                            thumbURL:(NSString *)thumbURL
                           SenderUid:(int64_t)senderUid
                         ReceiverUid:(int64_t)receiverUid
                    ChatType:(Header_ChatMsgType)chatType;


/**
 构建语音消息
 
 @param URL 语音URL
 @param voiceTime 语音时长
 @param senderUid 发送方
 @param receiverUid 接收方
 */
+(void)sendChatVoiceMsg:(NSString *)URL
                           VoiceTime:(int32_t)voiceTime
                           SenderUid:(int64_t)senderUid
                         ReceiverUid:(int64_t)receiverUid
                         ChatType:(Header_ChatMsgType)chatType;


/**
 构建抖一抖
 
 @param senderUid 发送方
 @param receiverUid 接收方
 */
+(void)sendShakeRequestMsgSenderUid:(int64_t)senderUid ReceiverUid:(int64_t)receiverUid ChatType:(Header_ChatMsgType)chatType;

/**
 构建心跳包
 */
+(void)builderHeartBeatMsgChatType:(Header_ChatMsgType)chatType;
@end

NS_ASSUME_NONNULL_END