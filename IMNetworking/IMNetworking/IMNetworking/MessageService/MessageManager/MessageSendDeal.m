//
//  MessageSendDeal.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "MessageSendDeal.h"//发送消息处理
@interface MessageSendDeal()
@property (nonatomic,strong)  MessageSendModel *model;
@end

@implementation MessageSendDeal
static MessageSendDeal *_messgaeSend = nil;
+ (MessageSendDeal *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messgaeSend = [[MessageSendDeal alloc] init];
    });
    return _messgaeSend;
}
-(void)setSendModel:(MessageSendModel *)sendModel{
    _model = sendModel;
}

-(NSData *)getSendMessageData{
    
    NSMutableData *msgData = [NSMutableData dataWithCapacity:4];
    /**
     total 和 headerlength 要求 4byte
     total length（4+headerLength+bodyLength）+ header length + header data + body lenth + body data
     */
    NSData *msgHeaderData = [_model.msgHeader data];
    //1、    total length
    int totalLength = (int)msgHeaderData.length + (int)_model.bodyData.length + 4;
    [msgData appendData:[self dataLengthForByte:totalLength]];
    
    //2、 header Length
    int headerLength = (int)msgHeaderData.length;
    [msgData appendData:[self dataLengthForByte:headerLength]];
    
    //3、 header data + body lenth
    NSData *haderData = [[NSData alloc]initWithBytes:msgHeaderData.bytes length:headerLength];
    [msgData appendData:haderData];
    //4、  body
    NSData *bodyData = [[NSData alloc]initWithBytes:_model.bodyData.bytes length:_model.bodyData.length];
    [msgData appendData:bodyData];
    
    return msgData.copy;
}
/**
 对data进行4字节长度转化
 return byteData
 */
-(NSData *)dataLengthForByte:(int)dataLenth{
    Byte btyeLen[4] = {};
    btyeLen[0] =(Byte)((dataLenth & 0xFF000000)>>24);
    btyeLen[1] =(Byte)((dataLenth & 0x00FF0000)>>16);
    btyeLen[2] =(Byte)((dataLenth & 0x0000FF00)>>8);
    btyeLen[3] =(Byte)((dataLenth & 0x000000FF));
    NSData *byteData = [[NSData alloc]initWithBytes:btyeLen length:4];
    return byteData;
}

@end
