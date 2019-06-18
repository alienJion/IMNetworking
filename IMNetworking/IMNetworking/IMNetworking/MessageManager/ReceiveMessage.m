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
            switch (model.msgHeader.statusCode) {//状态
                case StatusCode_Success://成功
                    [self dealMessageType:model];
                    break;
                case StatusCode_TokenInvalid://token失效
//                    弹出登录
                    break;
                case StatusCode_Failed://失败
                    
                    break;
                case StatusCode_HaspendingCtrlMsg://有正在处理的控制信息
                    
                    break;
                case StatusCode_NotLogin://未登录
//                    弹出登录
                    break;
                case StatusCode_UserHasOnlineInvalid: /** 用户在其他设备上已登录 */
//                    强制退出
                    break;
                default:
                    break;
            }
        }
    }];
}
//处理消息类型
-(void)dealMessageType:(MessageModel *)model{
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
//        case MessageType_LogoutResponse://退出登录
//            [self logoutMsg:model];
//            break;
//        case MessageType_HeartbeatAck://心跳反馈
//            //                    心跳反馈暂时不做处理
//            break;
//        case MessageType_MsgHandshakeResponse://握手消息反馈
//
//            break;
        case MessageType_ChatAck://聊天消息反馈
            [self sendMessageSuccess];
            break;
            
        default:
            NSLog(@"%s中对应的消息类型：%d",__func__,model.msgHeader.msgType);
            break;
    }
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
-(void)sendMessageSuccess{
    if ([self.recMsgDelegate respondsToSelector:@selector(receiveSendMsgsuccess)]) {
        [self.recMsgDelegate receiveSendMsgsuccess];
    }
}
// 读取消息包
- (void)readPacket{
    [[PacketService shareInstance] readPacket];
}


@end
