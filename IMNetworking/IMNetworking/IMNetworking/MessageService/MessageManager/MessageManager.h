//
//  MessageManager.h
//  IMNetworking
//
//  Created by Alien on 2019/6/14.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageManager : NSObject
+ (MessageManager *)shareInstance;

/**
 发送文字消息（包括系统表情）
 
 @param text 发送的文字
 @param to 接收方
 @param ext 扩展信息
 */
-(void)sendTextMessage:(NSString*)text
                toUser:(long long)to
                   ext:(NSData * _Nullable )ext;
/**
 发送心跳
 */
-(void)sendBeatMessage;
@end

NS_ASSUME_NONNULL_END
