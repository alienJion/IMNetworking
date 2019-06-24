//
//  AudioRecord.h
//  Utilities
//
//  Created by 松涛王 on 2019/6/21.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioRecord : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>

//获取单列
+(AudioRecord *)shareAudioRecord;

//停止录音
-(void)stopRecord;
//开始录音
-(void)startRecord;
//初始化音频检查
-(void)initRecordSession;
//初始化存储路径
-(NSString *)audioRecordPath;


@property(nonatomic, retain) AVAudioRecorder *audioRecorder;//音频录音机

@property (nonatomic , retain) AVAudioPlayer *audioPlayer;

@property (nonatomic,strong) NSString *uploadUrl;



@end

NS_ASSUME_NONNULL_END
