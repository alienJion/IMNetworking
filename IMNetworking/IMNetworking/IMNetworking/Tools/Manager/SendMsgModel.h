//
//  SendMsgModel.h
//  XJIM
//
//  Created by Alien on 2019/6/13.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgHeaderpbobjc.h"//消息头
NS_ASSUME_NONNULL_BEGIN

@interface SendMsgModel : NSObject
+ (SendMsgModel *)shareInstance;

@property(nonatomic,strong)NSData *bodyData;
@property (nonatomic,strong) Header *msgHeader;
/**
 获取配置将要发送的消息体
 */
-(NSData *)getSendMessageData;
@end

NS_ASSUME_NONNULL_END
