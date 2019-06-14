//
//  SendMessage.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "SendMessage.h"//发送消息

@implementation SendMessage
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
              ChatType:(Header_ChatMsgType)chatType{
    ChatTextMsg *chatTextMsg = [BuilderMessage builderChatTextMsg:content SenderUid:senderUid ReceiverUid:receiverUid];
    Header *header = [BuilderMessage builderHeader:(int32_t)[chatTextMsg data].length MsgType:MessageType_ChatTextSend ChatType:chatType];
    NSData *sendData = [MessageProtoBuf builderProtoBufMessage:[chatTextMsg data] HeaderData:[header data]];
    [[SocketManager shareInstance] sendMsgPacket:sendData];
}
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
ChatType:(Header_ChatMsgType)chatType{
    
    ChatImageMsg *chatImageMsg = [BuilderMessage builderChatImageMsg:originalURL thumbURL:thumbURL SenderUid:senderUid ReceiverUid:receiverUid];
    Header *header = [BuilderMessage builderHeader:(int32_t)[chatImageMsg data].length MsgType:MessageType_ChatImageSend ChatType:chatType];
    NSData *sendData = [MessageProtoBuf builderProtoBufMessage:[chatImageMsg data] HeaderData:[header data]];
    [[SocketManager shareInstance] sendMsgPacket:sendData];
    
}


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
ChatType:(Header_ChatMsgType)chatType{
   ChatVoiceMsg *chatVoiceMsg = [BuilderMessage builderChatVoiceMsg:URL VoiceTime:voiceTime SenderUid:senderUid ReceiverUid:receiverUid];
    Header *header = [BuilderMessage builderHeader:(int32_t)[chatVoiceMsg data].length MsgType:MessageType_ChatVoiceSend ChatType:chatType];
    NSData *sendData = [MessageProtoBuf builderProtoBufMessage:[chatVoiceMsg data] HeaderData:[header data]];
    [[SocketManager shareInstance] sendMsgPacket:sendData];
}


/**
 构建抖一抖
 
 @param senderUid 发送方
 @param receiverUid 接收方
 */
+(void)sendShakeRequestMsgSenderUid:(int64_t)senderUid ReceiverUid:(int64_t)receiverUid ChatType:(Header_ChatMsgType)chatType{
   ShakeRequestMsg *shakeRequestMsg = [BuilderMessage builderShakeRequestMsgSenderUid:senderUid ReceiverUid:receiverUid];
    Header *header = [BuilderMessage builderHeader:(int32_t)[shakeRequestMsg data].length MsgType:MessageType_ShakeRequest ChatType:chatType];
    NSData *sendData = [MessageProtoBuf builderProtoBufMessage:[shakeRequestMsg data] HeaderData:[header data]];
    [[SocketManager shareInstance] sendMsgPacket:sendData];
}

/**
 构建心跳包
 
 */
+(void)builderHeartBeatMsgChatType:(Header_ChatMsgType)chatType{
    HeartBeatMsg *heartBeatMsg = [BuilderMessage builderHeartBeatMsg];
    Header *header = [BuilderMessage builderHeader:(int32_t)[heartBeatMsg data].length MsgType:MessageType_Heartbeat ChatType:chatType];
    NSData *sendData = [MessageProtoBuf builderProtoBufMessage:[heartBeatMsg data] HeaderData:[header data]];
    [[SocketManager shareInstance] sendMsgPacket:sendData];
}
@end
