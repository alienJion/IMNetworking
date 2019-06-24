//
//  PlayRecord.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/22.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "PlayRecord.h"

@implementation PlayRecord

+ (PlayRecord *)sharePlayRecord{
    static PlayRecord *shareAccountManagerInstance=nil;
    static dispatch_once_t predicate;dispatch_once(&predicate, ^{
        shareAccountManagerInstance = [[self alloc ] init];
    });
    return shareAccountManagerInstance;
}
-(void)playerRecord:(NSString *)playerPath{
////    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"aac"];
////    NSString* musicPath = [[NSBundle mainBundle]pathForResource:@"sample" ofType:@"aac"];
////    NSLog(@"%@",musicPath);
//    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:musicPath] error:nil];
//
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:playerPath]];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:nil];

    self.audioPlayer.volume = 1;//播放器的音频增益，值：0.0～1.0
    self.audioPlayer.numberOfLoops = 0;//循环次数，如果要单曲循环，设置为负数
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

//-(void)playerRecord:(NSString *)playerPath{
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [session setActive:YES error:nil];
//    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:playerPath]];
//    NSError *error = nil;
//    AVAudioPlayer *player= [[AVAudioPlayer alloc] initWithData:data error:&error];
//    self.audioPlayer = player;
//
//    NSLog(@"%@",error);
//    if (self.audioPlayer != nil) {
//        self.audioPlayer.delegate = self;
//
//        if ([self.audioPlayer prepareToPlay] == YES &&
//            [self.audioPlayer play] == YES) {
//            NSLog(@"开始播放音频！");
//        } else {
//            [YWindow XJShowToast:@"播放失败"];
//        }
//    }else {
//        [YWindow XJShowToast:@"播放失败"];
//    }
//    self.audioPlayer=nil;
//}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if(flag==YES){
        NSLog(@"播放完成");
    }
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    NSLog(@"%@",error);
}
@end
