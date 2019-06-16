//
//  BuilderMessage.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgChatpbobjc.h"
//#import "MsgHeaderpbobjc.h"
//#import "BuilderMessage.h"
//#import "MsgShakepbobjc.h"
//#import "MsgHeartbeatpbobjc.h"
#import "HandleMsgHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuilderMessage : NSObject
/**
 构建文本消息 (包含自带图标)
 
 @param content 消息内容
 @param senderUid 发送方id
 @param receiverUid 接收方id
 @return ChatTextMsg
 */
+(ChatTextMsg *)builderChatTextMsg:(NSString *)content
                         SenderUid:(int64_t)senderUid
                       ReceiverUid:(int64_t)receiverUid;

/**
 构建图片消息

 @param originalURL 原图
 @param thumbURL 缩略图
 @param senderUid 发送方
 @param receiverUid 接收方
 @return ChatImageMsg对象
 */
+(ChatImageMsg *)builderChatImageMsg:(NSString *)originalURL
                            thumbURL:(NSString *)thumbURL
                            SenderUid:(int64_t)senderUid
                       ReceiverUid:(int64_t)receiverUid;


/**
 构建语音消息

 @param URL 语音URL
 @param voiceTime 语音时长
 @param senderUid 发送方
 @param receiverUid 接收方
 @return ChatVoiceMsg
 */
+(ChatVoiceMsg *)builderChatVoiceMsg:(NSString *)URL
                            VoiceTime:(int32_t)voiceTime
                           SenderUid:(int64_t)senderUid
                         ReceiverUid:(int64_t)receiverUid;


/**
 构建抖一抖

 @param senderUid 发送方
 @param receiverUid 接收方
 @return ShakeRequestMsg对象
 */
+(ShakeRequestMsg *)builderShakeRequestMsgSenderUid:(int64_t)senderUid ReceiverUid:(int64_t)receiverUid;

/**
 构建正在输入
 
 @return 正在输入
 */
+(TypingRequestMsg *)buildertTypingMsgSenderUid:(int64_t)senderUid ReceiverUid:(int64_t)receiverUid;
/**
 构建心跳包

 @return 心跳
 */
+(HeartBeatMsg *)builderHeartBeatMsg;

/**
 构建header

 @param bodyLen body的长度
 @param msgType 消息类型
 @param chatType 聊天类型
 @return header对象
 */
+(Header *)builderHeader:(int32_t)bodyLen MsgType:(MessageType)msgType ChatType:(Header_ChatMsgType)chatType;
@end

NS_ASSUME_NONNULL_END
