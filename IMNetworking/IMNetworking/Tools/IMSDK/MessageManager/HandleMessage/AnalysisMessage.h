//
//  AnalysisMessage.h
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageHeader.h"
#import "MsgProtobufHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnalysisMessage : NSObject
+ (AnalysisMessage *)shareInstance;
/**
 接收消息处理
 
 @param pBuffer 长链接接收到的消息
 */
- (void)handleRecvData:(NSData*)pBuffer;
@property (nonatomic,strong) RACSubject *analysisMsgSubject;
@end

NS_ASSUME_NONNULL_END
