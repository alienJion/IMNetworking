//
//  LinkService.m
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "LinkService.h"//链接服务
#import "SendMessage.h"//发送消息

#define BeatTime 3.0   //发送心跳时间。秒

@interface LinkService()<SocketLinkerDelegate>
@property(nonatomic,copy)ResultBlock resultBlock;

@property (nonatomic,strong) SocketManager *socketManager;
@property (nonatomic,strong) NSString *host;//地址
@property (nonatomic,assign) uint64_t port;//端口
// 心跳计时器
@property (nonatomic, strong) NSTimer *beatTimer;
@end
@implementation LinkService
//全局访问点
+ (LinkService *)shareInstance {
    static LinkService *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
#pragma mark-----------Delegate------------
//连接状态改变
- (void)connectDidChangeConnectState:(LinkStatus)newState {
    
    NSLog(@"当前链接状态：%ld",newState);
    self.linkStatus = newState;
}
//连接成功
- (void)socketDidConnectToHost:(NSString * _Nullable)host port:(uint16_t)port {
    NSLog(@"链接成功");
    if (self.resultBlock) {
        self.resultBlock(LinkResult_Success);
    }
    [SendMessage sendHandShakeRequestMsg];//发送握手消息
//    创建心跳定时器
    [self beatTimer];
}
//连接失败
- (void)socketDidDisconnectWithError:(NSError * _Nullable)error {
    NSLog(@"链接失败");
    if (self.resultBlock) {
        self.resultBlock(LinkResult_Error);
    }
//    重新链接服务器
    [self reConnectServer];
}


#pragma mark-----------Func----------------
//链接服务器
- (void)connectToHost:(NSString*)host onPort:(uint16_t)port result:(ResultBlock )resultBlock{
    self.resultBlock = resultBlock;
    self.host = host;
    self.port = port;
    [self connectServer];
}

- (SocketManager *)socketManager{
    if (_socketManager == nil) {
        _socketManager = [SocketManager shareInstance];
        _socketManager.linkerDelegate = self;
    }
    return _socketManager;
}
//连接服务器
- (void)connectServer{
    NSError *error = nil;
    [self.socketManager connectToHost:self.host onPort:self.port error:&error];
    if (error != nil) {
        NSLog(@"%s ---- %@",__func__,error);
    }
    
}
//重新链接服务器
- (void)reConnectServer{
    //    如果网络有问题就暂停，网路恢复继续连接
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateActive);
    //程序在前台才进行重连
    if (result) {
        [self connectServer];
    }
}
-(BOOL)isSocketConnected{
    return  [self.socketManager isSocketConnected];
}
//手动断开连接
- (void)cutOffSocket{
    [self.beatTimer invalidate];
    self.beatTimer = nil;
    [self.socketManager cutOffSocket];
}

-(NSTimer *)beatTimer{
    if (_beatTimer == nil) {
        _beatTimer = [NSTimer scheduledTimerWithTimeInterval:BeatTime target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
        // 把定时器添加到当前运行循环,并且调为通用模式
        [[NSRunLoop currentRunLoop] addTimer:_beatTimer forMode:NSRunLoopCommonModes];
    }
    return _beatTimer;
}


// 心跳连接
- (void)longConnectToSocket
{
    [SendMessage sendHeartBeat];
}
@end
