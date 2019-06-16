//
//  PacketService.m
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "PacketService.h"//数据包服务
#import "AnalysisMessage.h"//解析消息
#import "ReceiveMessage.h"//接收解析过的消息

@interface PacketService()<PacketDelegate>
@property (nonatomic,strong) SocketManager *socketManager;
@property (nonatomic,strong) NSMutableData *cacheData;

@end
@implementation PacketService
//全局访问点
+ (PacketService *)shareInstance {
    static PacketService *_instance = nil;
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
        self.cacheData = [NSMutableData dataWithCapacity:1024];
    }
    return self;
}

#pragma mark-----------Delegate------------
//收到消息
- (void)socketDidResponse:(NSData * _Nullable)data {
    AnalysisMessage *analysisMsg = [AnalysisMessage shareInstance];
    [analysisMsg handleRecvData:data];
    [analysisMsg.analysisMsgSubject subscribeNext:^(MessageModel *msgModel) {
        [[self msgModelSubject] sendNext:msgModel];
    }];
}


- (SocketManager *)socketManager{
    if (_socketManager == nil) {
        _socketManager = [SocketManager shareInstance];
        _socketManager.packetDelegate = self;
    }
    return _socketManager;
}
// 发送数据包
- (void)sendPacket:(NSData *)packet{
    [self.socketManager sendPacket:packet];
}
// 读取消息包
- (void)readPacket{
    [self.socketManager readPacket];

}
-(RACSubject *)msgModelSubject{
    if(_msgModelSubject == nil){
        _msgModelSubject = [RACSubject subject];
    }
    return _msgModelSubject;
}
@end
