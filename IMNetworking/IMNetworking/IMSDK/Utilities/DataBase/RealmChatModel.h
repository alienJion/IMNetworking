//
//  RealmChatModel.h
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/22.
//Copyright © 2019 ouwen. All rights reserved.
//
#import <Realm/Realm.h>

@interface RealmChatModel : RLMObject
/**
 聊天记录唯一标识
 */
@property NSString *message_id;
/**
 消息类型
 */
@property NSString *message_type;
/**
 消息内容
 */
@property NSString *message_content;
/**
 发送人唯一标识
 */
@property NSString *send_user_id;
/**
 发送人昵称
 */
@property NSString *send_user_nickName;
/**
 发送人头像
 */
@property NSString *send_user_img;
/**
 接收人唯一标识
 */
@property NSString *reciever_user_id;
/**
 接收人昵称
 */
@property NSString *reciever_user_nickName;
/**
 接收人头像
 */
@property NSString *reciever_user_img;
/**
 标记删除状态 0 未删除 1 删除
 */
@property NSInteger status;
/**
 是否已读 0 未读 1 已读
 */
@property NSInteger read_status;
/**
 发送消息时间
 */
@property NSString *time;
/**
 会话id
 */
@property NSString *session_id;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmChatModel *><RealmChatModel>
RLM_ARRAY_TYPE(RealmChatModel)
