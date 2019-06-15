//
//  LinkService.h
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface LinkService : NSObject
/**连接状态*/
@property (nonatomic,assign) LinkStatus linkStatus;
//单例
+ (LinkService *)shareInstance;
//建立链接
- (void)connectToHost:(NSString*)host onPort:(uint16_t)port;
//手动断开连接
- (void)cutOffSocket;
//判断Socket连接状态供外界调用
- (BOOL)isSocketConnected;
@end

NS_ASSUME_NONNULL_END
