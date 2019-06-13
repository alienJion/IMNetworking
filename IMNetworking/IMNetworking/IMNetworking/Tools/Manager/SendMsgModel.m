//
//  SendMsgModel.m
//  XJIM
//
//  Created by Alien on 2019/6/13.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "SendMsgModel.h"

@implementation SendMsgModel
static SendMsgModel *_sendMsgModel = nil;
+ (SendMsgModel *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sendMsgModel = [[SendMsgModel alloc] init];
        [_sendMsgModel msgHeader];
    });
    return _sendMsgModel;
}
-(void)setBodyData:(NSData *)bodyData{
    _bodyData = bodyData;
    self.msgHeader.bodyLength = (int)_bodyData.length;
}
-(Header *)msgHeader{
    if (_msgHeader == nil) {
        _msgHeader = [[Header alloc]init];
        _msgHeader.protocolVersion = 1.0;
        _msgHeader.clientType = Header_ClientType_Iphone;
        _msgHeader.time = [self getNowTimeTimestamp].longLongValue * 1000;
        _msgHeader.deviceId = @"gdhshds";
    }
    return _msgHeader;
}
-(NSData *)getSendMessageData{
    
      NSMutableData *msgData = [NSMutableData dataWithCapacity:4];
        /**
         total 和 headerlength 要求 4byte
         total length（4+headerLength+bodyLength）+ header length + header data + body lenth + body data
         */
        NSData *msgHeaderData = [self.msgHeader data];
        //1、    total length
        int totalLength = (int)msgHeaderData.length + (int)_bodyData.length + 4;
        [msgData appendData:[self dataLengthForByte:totalLength]];
        
        //2、 header Length
        int headerLength = (int)msgHeaderData.length;
        [msgData appendData:[self dataLengthForByte:headerLength]];
        
        //3、 header data + body lenth
        NSData *haderData = [[NSData alloc]initWithBytes:msgHeaderData.bytes length:headerLength];
        [msgData appendData:haderData];
        //4、  body
        NSData *bodyData = [[NSData alloc]initWithBytes:_bodyData.bytes length:_bodyData.length];
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
-(NSString *)getNowTimeTimestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}
@end
