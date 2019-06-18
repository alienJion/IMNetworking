//
//  ViewController.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ViewController.h"
#import "SendMessage.h"//发送消息
#import "LinkService.h"//链接服务器
#import "ReceiveMessage.h"//接收消息

#import "UtilitiesHeader.h"

#define SocketHost @"192.168.1.137"
//#define SocketHost @"192.168.10.123"
#define SocketPort 7002

@interface ViewController ()<RecMsgDelegate>
@property (nonatomic,strong) NSData *personData;
@property (nonatomic,strong) SocketManager *socketManager;
@property (nonatomic,strong) ReceiveMessage *recMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LinkService shareInstance] connectToHost:SocketHost onPort:SocketPort result:^(LinkResultType linkResultType) {
        if (linkResultType == LinkResult_Success) {
//            [SendMessage sendHandShakeRequestMsg];//发送握手消息
            [[self recMessage] readPacket];
        }else{
            NSLog(@"链接服务器失败");
        }
    }];
    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SendMessage sendChatTextMsg:@"hello IM" SenderUid:0 ReceiverUid:0 ChatType:Header_ChatMsgType_Single];
    
}
-(ReceiveMessage *)recMessage{
    if (_recMessage == nil) {
        _recMessage = [[ReceiveMessage alloc]init];
        _recMessage.recMsgDelegate = self;
    }
    return _recMessage;
}

/**
 接收图片消息
 */
- (void)receiveChatImageMsg:(ChatImageMsg * _Nullable)chatImageMsg {
    
}
/**
 接收文字消息
 */
- (void)receiveChatTextMsg:(ChatTextMsg * _Nullable)chatTextMsg {
    
}
/**
 接收语音消息
 */
- (void)receiveChatVoiceMsg:(ChatVoiceMsg * _Nullable)chatVoiceMsg {
    
}
/**
 被踢下线
 */
- (void)receiveLogoutRequestMsg:(LogoutRequestMsg * _Nullable)logoutRequestMsg {
    
}
/**
 接收抖一抖消息
 */
- (void)receiveShakeRequestMsg:(ShakeRequestMsg * _Nullable)shakeRequestMsg {
    
}
/**
 正在输入
 */
- (void)receiveTypingRequestMsg:(TypingRequestMsg * _Nullable)typingRequestMsg {
    
}
/**
 消息发送成功
 */
-(void)receiveSendMsgsuccess{
    NSLog(@"消息发送成功");
}

@end
