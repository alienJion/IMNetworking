//
//  ReceiveMessage.m
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ReceiveMessage.h"//接收消息
#import "PacketService.h"//数据包服务
 

@implementation ReceiveMessage
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self receiveMessage];
    }
    return self;
}

-(void)receiveMessage{
    [[PacketService shareInstance].msgModelSubject subscribeNext:^(MessageModel *model) {
        if (self.recMsgDelegate) {
            switch (model.msgHeader.msgType) {
                case MessageType_ChatTextSend://文本消息
                    [self chatTextMsg:model];
                    break;
                case MessageType_ChatImageSend://图片消息
                    [self chatImageMsg:model];
                    break;
                case MessageType_ChatVoiceSend://语音消息
                    [self chatVoiceMsg:model];
                    break;
                case MessageType_ShakeRequest://抖一抖
                    [self shakeMsg:model];
                    break;
                case MessageType_TypingRequest://正在输入
                    [self typingMsg:model];
                    break;
                case MessageType_LogoutResponse://正在输入
                    [self logoutMsg:model];
                    break;
                default:
                    NSLog(@"%s中对应的消息类型：%d",__func__,model.msgHeader.msgType);
                    break;
            }
        }
    }];
}

-(void)chatTextMsg:(MessageModel *)model{
    if([self.recMsgDelegate respondsToSelector:@selector(receiveChatTextMsg:)]){
        ChatTextMsg *chatTextMsgModel = [[ChatTextMsg alloc]initWithData:model.msgBodyData error:nil];
        [self.recMsgDelegate receiveChatTextMsg:chatTextMsgModel];
    }
}
-(void)chatImageMsg:(MessageModel *)model{
    if([self.recMsgDelegate respondsToSelector:@selector(receiveChatImageMsg:)]){
        ChatImageMsg *chatImageMsgModel = [[ChatImageMsg alloc]initWithData:model.msgBodyData error:nil];
        [self.recMsgDelegate receiveChatImageMsg:chatImageMsgModel];
    }
}
-(void)chatVoiceMsg:(MessageModel *)model{
    if([self.recMsgDelegate respondsToSelector:@selector(receiveChatVoiceMsg:)]){
        ChatVoiceMsg *chatVoiceMsgModel = [[ChatVoiceMsg alloc]initWithData:model.msgBodyData error:nil];
        [self.recMsgDelegate receiveChatVoiceMsg:chatVoiceMsgModel];
    }
}
-(void)shakeMsg:(MessageModel *)model{
    if([self.recMsgDelegate respondsToSelector:@selector(receiveShakeRequestMsg:)]){
        ShakeRequestMsg *shakeModel = [[ShakeRequestMsg alloc]initWithData:model.msgBodyData error:nil];
        [self.recMsgDelegate receiveShakeRequestMsg:shakeModel];
    }
}
-(void)typingMsg:(MessageModel *)model{
    if([self.recMsgDelegate respondsToSelector:@selector(receiveTypingRequestMsg:)]){
        TypingRequestMsg *typingMsgModel = [[TypingRequestMsg alloc]initWithData:model.msgBodyData error:nil];
        [self.recMsgDelegate receiveTypingRequestMsg:typingMsgModel];
    }
}
-(void)logoutMsg:(MessageModel *)model{
    if([self.recMsgDelegate respondsToSelector:@selector(receiveLogoutRequestMsg:)]){
        LogoutRequestMsg *logoutMsgModel = [[LogoutRequestMsg alloc]initWithData:model.msgBodyData error:nil];
        [self.recMsgDelegate receiveLogoutRequestMsg:logoutMsgModel];
    }
}










// 读取消息包
- (void)readPacket{
    [[PacketService shareInstance] readPacket];
}


@end
