//
//  ReceiveMessage.h
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgProtobufHeader.h"


//设置代理方法
@protocol RecMsgDelegate <NSObject>
/**
 接收文本消息 (包含自带图标)
 */
-(void)receiveChatTextMsg:(ChatTextMsg *_Nullable)chatTextMsg;
/**
 接收图片消息
 */
-(void)receiveChatImageMsg:(ChatImageMsg *_Nullable)chatImageMsg;
/**
 接收语音消息
 */
-(void)receiveChatVoiceMsg:(ChatVoiceMsg *_Nullable)chatVoiceMsg;
/**
 接收抖一抖
 */
-(void)receiveShakeRequestMsg:(ShakeRequestMsg *_Nullable)shakeRequestMsg;
/**
 接收正在输入
 */
-(void)receiveTypingRequestMsg:(TypingRequestMsg *_Nullable)typingRequestMsg;
/**
 被踢下线
 */
-(void)receiveLogoutRequestMsg:(LogoutRequestMsg *_Nullable)logoutRequestMsg;
/**
 消息发送成功
 */
-(void)receiveSendMsgsuccess;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveMessage : NSObject
@property (nonatomic, weak) id<RecMsgDelegate> recMsgDelegate;//消息回掉
// 读取消息包
- (void)readPacket;
@end

NS_ASSUME_NONNULL_END
