//
//  AudioRecord.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/21.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "AudioRecord.h"

@implementation AudioRecord

+ (AudioRecord *)shareAudioRecord{
    static AudioRecord *shareAccountManagerInstance=nil;
    static dispatch_once_t predicate;dispatch_once(&predicate, ^{
        shareAccountManagerInstance = [[self alloc ] init];
    });
    return shareAccountManagerInstance;
}

//录音文件位置
- (NSString *)audioRecordPath{
    NSString *result=nil;
    NSArray *folders=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder=[folders objectAtIndex:0];
    
    result = [NSString stringWithFormat:@"%@/record.aac",documentsFolder];
    return result;
}
-(void)setUploadUrl:(NSString *)url{
    self.uploadUrl=url;
}

//参数配置
-(NSDictionary *)audioRecordingSetting{
    NSDictionary *setting = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithFloat:44100.0],AVSampleRateKey,//采样率
                             [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,//录音格式
                             [NSNumber numberWithInt:16] ,AVLinearPCMBitDepthKey,//线性采位数
                             [NSNumber numberWithInt:2],AVNumberOfChannelsKey,//声道
                             [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey//录音质量
                             , nil];
    return (setting);
}
//停止录制
-(void)stopRecordingOnAudioRecorder:(AVAudioRecorder *)recorder{
    [recorder stop];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if(flag==YES){
        NSLog(@"录音完成！");
    }else{
        NSLog(@"录制过程意外终止");
    }
    
}

-(NSString *)getUploadUrl{
    return self.uploadUrl;
}



- (void)initRecordSession{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    [session setActive:YES error:nil];
}

- (void)startRecord{
    
    [self initRecordSession];
    
    NSError *error = nil;
    NSString *pathOfRecordingFile = [self audioRecordPath];
    NSURL *audioRecordingUrl = [NSURL fileURLWithPath:pathOfRecordingFile];
    AVAudioRecorder *newRecorder = [[AVAudioRecorder alloc]
                                    initWithURL:audioRecordingUrl
                                    settings:[self audioRecordingSetting]
                                    error:&error];
    self.audioRecorder = newRecorder;
    if (self.audioRecorder != nil) {
        self.audioRecorder.delegate = self;
        if([self.audioRecorder prepareToRecord] == NO){
            return;
        }
        
        if ([self.audioRecorder record] == YES) {
            NSLog(@"录音开始！");
//            [self performSelectorOnMainThread:@selector(stopRecordingOnAudioRecorder:) withObject:self.audioRecorder waitUntilDone:YES];
            
        } else {
            NSLog(@"录音失败！");
            self.audioRecorder =nil;
        }
    } else {
        NSLog(@"auioRecorder实例录音器失败！");
    }
}
- (void)stopRecord{
    if (self.audioRecorder != nil) {
        if ([self.audioRecorder isRecording] == YES) {
            [self.audioRecorder stop];
        }
        self.audioRecorder = nil;
    }
    
    
    
}



@end
