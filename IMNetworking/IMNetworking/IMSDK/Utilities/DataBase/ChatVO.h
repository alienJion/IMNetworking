//
//  ChatVO.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/22.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatVO : NSObject
+ (ChatVO *)shareInstance;
#pragma mark    增
/**
 保存一个model到数据库中

 @param model 聊天model
 */
-(void)addChatVO:(ChatModel *)model;
#pragma mark    删
/**
 删除数据库中的所有数据
 */
-(void)deleteAllObjects;
/**
 根据会话id删除对应数据

 @param sessionId 会话id
 */
-(void)deleteObjectWithSessionId:(NSString *)sessionId;
#pragma mark    改
/**
 更新数据

 @param messageid 消息id
 @param model 对应的model
 */
-(void)updateObjectsWhereMessageId:(NSString *)messageid  withChatModel:(ChatModel *)model;

#pragma mark    查
/**
 获取数据库中的所有model数据
 
 @return 数组
 */
-(NSArray <ChatModel *> *)allObjects;
/**
 根据会话ID获取model数据
 */
-(NSArray <ChatModel *> *)objectsWhereSessionId:(NSString *)sessionId;
@end

NS_ASSUME_NONNULL_END
