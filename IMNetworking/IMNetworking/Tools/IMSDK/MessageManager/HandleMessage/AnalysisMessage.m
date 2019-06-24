//
//  AnalysisMessage.m
//  IMNetworking
//
//  Created by Alien on 2019/6/16.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "AnalysisMessage.h"//解析消息


#define TotalLen 4
#define HeadLen 4

@interface AnalysisMessage()
@property (nonatomic,strong) NSMutableData *cacheData;
@end
@implementation AnalysisMessage

//全局访问点
+ (AnalysisMessage *)shareInstance {
    static AnalysisMessage *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheData = [[NSMutableData alloc]init];
    }
    return self;
}

- (void)handleRecvData:(NSData*)pBuffer{
    [self.cacheData appendData:pBuffer];
    int placeholderLen = (TotalLen+HeadLen);//total+header占用8个字节。 如果数据过来大于8个字节进行解析
    if (self.cacheData.length > placeholderLen) {
        int64_t totalL = [self handleTotalLenghtData:self.cacheData];
        NSLog(@"totalLength ==== %lld",totalL);
        if (self.cacheData.length > totalL) {
            int64_t headL = [self handleHeaderLenghtData:self.cacheData];
            NSLog(@"headLength ====== %lld",headL);
            if (headL + placeholderLen < self.cacheData.length) {
                Header *header = [self handleHeaderDataLenght:headL];
                MessageModel *msgModel = [[MessageModel alloc]init];
                msgModel.msgHeader = header;
                if((placeholderLen + headL + header.bodyLength) <= self.cacheData.length){
                    if(header.bodyLength == 0){
//                        没有接收到body信息
                    }else{
                        NSData *bodyData = [self.cacheData subdataWithRange:NSMakeRange(placeholderLen + headL, header.bodyLength)];
                        msgModel.msgBodyData = bodyData;
                    }
                    [self.analysisMsgSubject sendNext:msgModel];
                    //读取完成后对这次数据进行删除
                    [self.cacheData replaceBytesInRange:NSMakeRange(0, headL + placeholderLen + header.bodyLength) withBytes:NULL length:0];
                }else{
                    [[SocketManager shareInstance] readPacket];
                }
            }else{
                [[SocketManager shareInstance] readPacket];
            }
        }else{
            [[SocketManager shareInstance] readPacket];
        }
    }else{
        [[SocketManager shareInstance] readPacket];
    }
}

/**
 totallength（4+headerLength+bodyLength）包的总长度
 
 @param pBuffer 原始数据
 @return total对应的长度
 */
-(int64_t)handleTotalLenghtData:(NSData *)pBuffer{
    NSData *totalData =[pBuffer subdataWithRange:NSMakeRange(0, TotalLen)];
    //     total是整个包的长度
    return [self unpackRecvDataLen:totalData DataLength:TotalLen];
}

/**
 header的长度，存放在4到8个字节
 
 @param pBuffer 原始数据
 @return total对应的长度
 */
-(int64_t)handleHeaderLenghtData:(NSData *)pBuffer{
    NSData *headData =[pBuffer subdataWithRange:NSMakeRange(TotalLen, (TotalLen+HeadLen))];
    return  [self unpackRecvDataLen:headData DataLength:HeadLen];
}

/**
 处理header
 */
-(Header *)handleHeaderDataLenght:(int64_t)headL{
    NSData *headData =[self.cacheData subdataWithRange:NSMakeRange((TotalLen+HeadLen), headL)];
    NSError *error = nil;
    Header *header = [[Header alloc]initWithData:headData error:&error];
    if(error == nil){
        return header;
    }else{
        NSLog(@"header解析失败：%@",error);
        return  nil;
    }
}

//计算length
-(int64_t)unpackRecvDataLen:(NSData*)recData DataLength:(int)len
{
    //代表没有待处理数据
    if ([recData length]< len) {
        return 0;
    }
    //    对data转化bytes
    const unsigned char * p = [recData bytes];
    int64_t rLen = 0;
    //   对p拷贝PackageTotalLen个字节到rlen
    memcpy(&rLen, p, len);
    //    进行字节对齐处理
    int64_t totalLen = ntohl(rLen);
    
    return totalLen;
}
-(RACSubject *)analysisMsgSubject{
    if (_analysisMsgSubject == nil) {
        _analysisMsgSubject = [RACSubject subject];
    }
    return _analysisMsgSubject;
}
@end
