//
//  ChatVO.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/22.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealmChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatVO : NSObject
+ (ChatVO *)shareInstance;
/**
 保存一个model到数据库中

 @param model 聊天model
 */
-(void)addChatVO:(RealmChatModel *)model;
/**
 删除数据库中的所有数据
 */
-(void)deleteAllObjects;
/**
根据会话ID删除
 */
-(NSArray <RealmChatModel *> *)objectsWhereSessionId:(NSString *)sessionId;

/**
 获取数据库中的所有model数据
 
 @return 数组
 */
-(NSArray <RealmChatModel *> *)allObjects;
@end

NS_ASSUME_NONNULL_END
