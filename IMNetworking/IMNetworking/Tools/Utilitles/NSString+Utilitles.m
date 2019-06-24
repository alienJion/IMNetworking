//
//  NSString+Utilitles.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/20.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "NSString+Utilitles.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (Utilitles)
+ (instancetype)fd_stringWithFormat:(NSString *)format{
    return [NSString nullToString:format];
}
+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(stringWithFormat:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(fd_stringWithFormat:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
+ (NSString *)nullToString:(id)string {
    if ([string isEqual:@"NULL"] || [string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
        return @"";
    } else {
        return (NSString *)string;
    }
}
-(NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
