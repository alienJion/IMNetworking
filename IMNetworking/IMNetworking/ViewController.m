//
//  ViewController.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ViewController.h"
#import "SendMessage.h"//发送消息
#import "LinkService.h"
#import "UtilitiesHeader.h"

#define SocketHost @"192.168.1.137"
//#define SocketHost @"192.168.10.123"
#define SocketPort 7002

@interface ViewController ()
@property (nonatomic,strong) NSData *personData;
@property (nonatomic,strong) SocketManager *socketManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LinkService shareInstance] connectToHost:SocketHost onPort:SocketPort];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SendMessage sendChatTextMsg:@"hello IM" SenderUid:0 ReceiverUid:0 ChatType:Header_ChatMsgType_Single];
    
}

@end
