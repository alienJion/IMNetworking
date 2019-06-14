//
//  BuilderMessage.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "BuilderMessage.h"//构建消息

@implementation BuilderMessage
/**
 构建文本消息
 
 @param content 消息内容
 @param senderUid 发送方id
 @param receiverUid 接收方id
 @return ChatTextMsg
 */
+(ChatTextMsg *)builderChatTextMsg:(NSString *)content SenderUid:(int64_t)senderUid ReceiverUid:(int64_t)receiverUid {
    ChatTextMsg *textMsg = [[ChatTextMsg alloc]init];
    textMsg.content = content;
    textMsg.senderUid = senderUid;
    textMsg.receiverUid = receiverUid;
    return textMsg;
}
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
                         ReceiverUid:(int64_t)receiverUid{
    ChatImageMsg *chatImageMsg = [ChatImageMsg new];
    chatImageMsg.originalURL = originalURL;
    chatImageMsg.thumbURL = thumbURL;
    chatImageMsg.senderUid = senderUid;
    chatImageMsg.receiverUid = receiverUid;
    return chatImageMsg;
}


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
                         ReceiverUid:(int64_t)receiverUid{
    ChatVoiceMsg *chatVoiceMsg = [ChatVoiceMsg new];
    chatVoiceMsg.URL = URL;
    chatVoiceMsg.voiceTime = voiceTime;
    chatVoiceMsg.senderUid = senderUid;
    chatVoiceMsg.receiverUid = receiverUid;
    return chatVoiceMsg;
}


/**
 构建抖一抖
 
 @param senderUid 发送方
 @param receiverUid 接收方
 @return ShakeRequestMsg对象
 */
+(ShakeRequestMsg *)builderShakeRequestMsgSenderUid:(int64_t)senderUid ReceiverUid:(int64_t)receiverUid{
    ShakeRequestMsg *shakeRequestMsg = [ShakeRequestMsg new];
    shakeRequestMsg.senderUid = senderUid;
    shakeRequestMsg.receiverUid = receiverUid;
    return shakeRequestMsg;
}

/**
 构建心跳包
 
 @return 心跳
 */
+(HeartBeatMsg *)builderHeartBeatMsg{
    return [HeartBeatMsg new];
}








+(Header *)builderHeader:(int32_t)bodyLen MsgType:(MessageType)msgType ChatType:(Header_ChatMsgType)chatType  {
    Header *header = [[Header alloc]init];
    header.msgType = msgType;
    header.bodyLength = bodyLen;
    header.chatMsgType = chatType;
    header.protocolVersion = 1.0;
    header.clientType = Header_ClientType_Iphone;
    header.time = [self getNowTimeTimestamp].longLongValue * 1000;
    header.deviceId = @"iOSdeviceId";
    header.appKey = @"iOSKey";
    return header;
}


+(NSString *)getNowTimeTimestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}
@end
