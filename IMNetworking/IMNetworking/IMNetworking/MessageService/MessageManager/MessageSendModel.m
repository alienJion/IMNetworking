//
//  MessageSendModel.m
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "MessageSendModel.h"//发送消息model

@implementation MessageSendModel
-(void)setBodyData:(NSData *)bodyData{
    _bodyData = bodyData;
    [self msgHeader].bodyLength = (int)_bodyData.length;
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
