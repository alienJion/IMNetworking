//
//  MessageProtoBuf.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "MessageProtoBuf.h"//构建协议转化protoBuf

@implementation MessageProtoBuf
/**
 将要发送的消息进行处理
 
 @param bodyData bodyData
 @param headerData headerData
 @return data
 */
+(NSData *)builderProtoBufMessage:(NSData *)bodyData HeaderData:(NSData *)headerData{
     NSMutableData *msgData = [NSMutableData dataWithCapacity:4];
    /**
     total 和 headerlength 要求 4byte
     total length（4+headerLength+bodyLength）+ header length + header data + body lenth + body data
     */

    //1、    total length
    int totalLength = (int)headerData.length + (int)bodyData.length + 4;
    [msgData appendData:[self dataLengthForByte:totalLength]];

    //2、 header Length
    int headerLength = (int)headerData.length;
    [msgData appendData:[self dataLengthForByte:headerLength]];
    
    //3、 header data + body lenth
    [msgData appendData:[[NSData alloc]initWithBytes:headerData.bytes length:headerLength]];
    //4、  body
    [msgData appendData:[[NSData alloc]initWithBytes:bodyData.bytes length:bodyData.length]];
    
    return msgData.copy;
}

/**
 对data进行4字节长度转化
 return byteData
 */
+(NSData *)dataLengthForByte:(int)dataLenth{
    Byte btyeLen[4] = {};
    btyeLen[0] =(Byte)((dataLenth & 0xFF000000)>>24);
    btyeLen[1] =(Byte)((dataLenth & 0x00FF0000)>>16);
    btyeLen[2] =(Byte)((dataLenth & 0x0000FF00)>>8);
    btyeLen[3] =(Byte)((dataLenth & 0x000000FF));
    NSData *byteData = [[NSData alloc]initWithBytes:btyeLen length:4];
    return byteData;
}
@end
