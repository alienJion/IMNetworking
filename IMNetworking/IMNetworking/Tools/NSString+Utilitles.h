//
//  NSString+Utilitles.h
//  Utilities
//
//  Created by 松涛王 on 2019/6/20.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utilitles)
+ (NSString *)nullToString:(id)string;
-(NSString *)md5;
@end

NS_ASSUME_NONNULL_END
