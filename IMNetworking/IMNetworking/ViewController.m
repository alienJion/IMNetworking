//
//  ViewController.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ViewController.h"
#import "MessageManager.h"
@interface ViewController ()
@property (nonatomic,strong) NSData *personData;
@property (nonatomic,strong) SocketManager *socketManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _socketManager = [SocketManager shareInstance];
    [_socketManager.sendMessageject subscribeNext:^(GCDAsyncSocket *sock) {
        
    }];
    [_socketManager connectToServer];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    if(self.socketManager.socket)
    //
    //        连接成功
    MessageManager *messageManager = [MessageManager shareInstance];
    [messageManager sendTextMessage:@"alien" toUser:1223343 ext:nil];
    
}

@end
