//
//  Utilitles.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "Utilitles.h"

@implementation Utilitles
+(NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData{
    if (jsonData.length == 0) {
        XJLog(@"data长度为0");
        return nil;
    }
    // NSString* aStr= [[NSString alloc] initWithData:jsonData   encoding:NSASCIIStringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&err];
    if(err) {
        NSString *dataStr;
        dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        XJLog(@"json解析失败：%@-------转化字符串结果:%@",err,dataStr);
        return nil;
    }
    return dic;
}
@end
