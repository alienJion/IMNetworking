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


-(void)addChatVO:(RealmChatModel *)model{
    [self.realm beginWriteTransaction];
    [self.realm addObject:model];//对Realm数据库进行读写操作，在Realm上开始写入事务, 每个Realm文件一次只能打开一个写事务
    NSError *error = nil;
    [self.realm commitWriteTransaction:&error];//在当前写入事务中提交所有写入操作，并结束事务
    if (error) {
        NSLog(@"%@",error);
        NSLog(@"保存失败请清理内存");
    }
}
-(NSArray <RealmChatModel *> *)allObjects{
    RLMResults <RealmChatModel*> *result = [RealmChatModel allObjects];
    
    return [self changeRLMResults:result];
}

-(NSArray <RealmChatModel *> *)objectsWhereSessionId:(NSString *)sessionId{
    
    RLMResults <RealmChatModel *> *result = [RealmChatModel objectsWhere:[NSString stringWithFormat:@"session_id = '%@'",sessionId]];
    return [self changeRLMResults:result];
}


-(void)deleteAllObjects{
    [self.realm transactionWithBlock:^{
        [self.realm deleteAllObjects];

    }];
}



-(RLMRealm *)realm{
    if (_realm == nil) {
        _realm = [RLMRealm defaultRealm];
    }
    return _realm;
}
-(NSArray *)changeRLMResults:(RLMResults *)result{
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
    for (RealmChatModel *model in result) {
        [modelArray addObject:model];
    }
    return modelArray.copy;
}
@end
