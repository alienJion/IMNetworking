//
//  PlayRecord.h
//  Utilities
//
//  Created by 松涛王 on 2019/6/22.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PlayRecord : NSObject<AVAudioPlayerDelegate>
//获取单列
+(PlayRecord *)sharePlayRecord;
-(void)playerRecord:(NSString *)playerPath;

@property (nonatomic , retain) AVAudioPlayer *audioPlayer;
@end

NS_ASSUME_NONNULL_END
