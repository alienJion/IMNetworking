//
//  ChatManager.m
//  XJIM
//
//  Created by Alien on 2019/6/13.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ChatManager.h"
#import "SendMsgModel.h"
@interface ChatManager ()
@property(nonatomic,strong)NSMutableData *sendData;
@property (nonatomic,strong)  Header *msgHeader;

@end

@implementation ChatManager
static ChatManager *_chatManager = nil;
+ (ChatManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _chatManager = [[ChatManager alloc] init];
    });
    return _chatManager;
}

/**
 发送文字消息（包括系统表情）
 
 @param text 发送的文字
 @param to 接收方
 @param ext 扩展信息
 */
-(void)sendTextMessage:(NSString*)text
                         toUser:(long long)to
                   ext:(NSData * _Nullable )ext{
    if (ext == nil) {
        ChatTextMsg *chatText = [[ChatTextMsg alloc]init];
        chatText.content = text;
        chatText.receiverUid = to;
        NSData *chatData = [chatText data];
        
        SendMsgModel *model = [SendMsgModel shareInstance];
        model.msgHeader.msgType = MessageType_ChatTextSend;//发送文本类型
        model.msgHeader.chatMsgType = Header_ChatMsgType_Single;//单聊
        model.bodyData = chatData;
        NSData *data = [model getSendMessageData];
        [[SocketManager shareInstance] sendMsgPacket:data];
    }
}
/**
 发送心跳
 */
-(void)sendBeatMessage{
    HeartBeatMsg *heart = [[HeartBeatMsg alloc]init];
    NSData *heartData = [heart data];
    SendMsgModel *model = [SendMsgModel shareInstance];
    model.msgHeader.msgType = MessageType_Heartbeat;//发送心跳
    model.bodyData = heartData;
    NSData *data = [model getSendMessageData];
    [[SocketManager shareInstance] sendMsgPacket:data];
}

@end
