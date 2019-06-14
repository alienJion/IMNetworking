//
//  MessageManager.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "MessageManager.h"
#import "MessageSendDeal.h"
@interface MessageManager ()
@property(nonatomic,strong)NSMutableData *sendData;
@property (nonatomic,strong)  Header *msgHeader;

@end
@implementation MessageManager
static MessageManager *_messageManager = nil;
+ (MessageManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messageManager = [[MessageManager alloc] init];
    });
    return _messageManager;
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
        NSData *textData = [chatText data];
        
        MessageSendModel *model = [[MessageSendModel alloc]init];
        model.bodyData = textData;
        model.msgHeader.msgType = MessageType_ChatTextSend;//发送文本类型
        model.msgHeader.chatMsgType = Header_ChatMsgType_Single;//单聊
        
        MessageSendDeal *sendDealModel = [MessageSendDeal shareInstance];
        sendDealModel.sendModel = model;
        NSData *data = [sendDealModel getSendMessageData];
        [[SocketManager shareInstance] sendMsgPacket:data];
    }
}
/**
 发送心跳
 */
-(void)sendBeatMessage{
    HeartBeatMsg *heart = [[HeartBeatMsg alloc]init];
    NSData *heartData = [heart data];
    MessageSendModel *model = [[MessageSendModel alloc]init];
    model.bodyData = heartData;
    model.msgHeader.msgType = MessageType_Heartbeat;//心跳
    
    MessageSendDeal *sendModel = [MessageSendDeal shareInstance];
    sendModel.sendModel = model;
    NSData *data = [sendModel getSendMessageData];
    [[SocketManager shareInstance] sendMsgPacket:data];
}

@end
