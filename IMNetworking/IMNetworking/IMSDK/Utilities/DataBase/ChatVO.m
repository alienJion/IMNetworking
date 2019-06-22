//
//  ChatVO.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/22.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ChatVO.h"
@interface ChatVO()
@property (nonatomic,strong) RLMRealm *realm;
@end
@implementation ChatVO
//全局访问点
+ (ChatVO *)shareInstance {
    static ChatVO *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark    增
-(void)addChatVO:(ChatModel *)model{
    [self.realm beginWriteTransaction];
    [self.realm addObject:model];//对Realm数据库进行读写操作，在Realm上开始写入事务, 每个Realm文件一次只能打开一个写事务
    NSError *error = nil;
    [self.realm commitWriteTransaction:&error];//在当前写入事务中提交所有写入操作，并结束事务
    if (error) {
        NSLog(@"%@",error);
        NSLog(@"保存失败请清理内存");
    }
}

#pragma mark    删
-(void)deleteObjectWithSessionId:(NSString *)sessionId{
    NSArray *chatModelArray = [self objectsWhereSessionId:sessionId];
    for (ChatModel *model in chatModelArray) {
        [self.realm transactionWithBlock:^{
            [self.realm deleteObject:model];
        }];
    }
}
-(void)deleteAllObjects{
    [self.realm transactionWithBlock:^{
        [self.realm deleteAllObjects];
        
    }];
}

#pragma mark    改
-(void)updateObjectsWhereMessageId:(NSString *)messageid  withChatModel:(ChatModel *)model{
    //这里面修改的模型,一定是被realm所管理的模型
    NSString *where = [NSString stringWithFormat:@"message_id = '%@'",messageid];
    RLMResults <ChatModel *> *result = [ChatModel objectsWhere:where];
    NSArray *modelArray = [self changeRLMResults:result];
    for (ChatModel *chatModel in modelArray) {
        [self.realm transactionWithBlock:^{
             chatModel.status = model.status;
            chatModel.read_status = model.read_status;
        }];
    }
    
}


#pragma mark    查
-(NSArray <ChatModel *> *)allObjects{
    RLMResults <ChatModel*> *result = [ChatModel allObjects];
    
    return [self changeRLMResults:result];
}

-(NSArray <ChatModel *> *)objectsWhereSessionId:(NSString *)sessionId{
    NSString *where = [NSString stringWithFormat:@"session_id = '%@'",sessionId];
    RLMResults <ChatModel *> *result = [ChatModel objectsWhere:where];
    return [self changeRLMResults:result];
}






-(RLMRealm *)realm{
    if (_realm == nil) {
        _realm = [RLMRealm defaultRealm];
    }
    return _realm;
}
-(NSArray *)changeRLMResults:(RLMResults *)result{
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
    for (ChatModel *model in result) {
        [modelArray addObject:model];
    }
    return modelArray.copy;
}
@end
