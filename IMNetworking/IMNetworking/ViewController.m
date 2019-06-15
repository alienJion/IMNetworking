//
//  ViewController.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ViewController.h"
#import "SendMessage.h"//发送消息
@interface ViewController ()
@property (nonatomic,strong) NSData *personData;
@property (nonatomic,strong) SocketManager *socketManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _socketManager = [SocketManager shareInstance];
    
    [_socketManager connectToServer];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    if(self.socketManager.socket)
    //
    //        连接成功
    [SendMessage sendChatTextMsg:@"hello IM" SenderUid:0 ReceiverUid:0 ChatType:Header_ChatMsgType_Single];
    
}

@end
