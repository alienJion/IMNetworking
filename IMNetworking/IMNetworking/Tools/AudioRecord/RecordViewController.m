//
//  RecordViewController.m
//  Utilities
//
//  Created by 松涛王 on 2019/6/21.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "RecordViewController.h"
#import "AudioRecord.h"
#import "PlayRecord.h"
@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"录制语音";
    self.animeImageView.hidden=YES;
    self.commonBtn.layer.cornerRadius = 5.0f;
    [self initImageAnimation];
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration=0.5;
    [self.commonBtn addGestureRecognizer:longPress];
    [self stopAnimation];

}

-(void)startAnimation{
    self.animeImageView.hidden=NO;
    if(self.animeImageView.isAnimating){
        [self.animeImageView stopAnimating];
        [self.animeImageView startAnimating];
    }else{
        [self.animeImageView startAnimating];
    }
}
    
-(void)stopAnimation{
    [self.animeImageView stopAnimating];
    self.animeImageView.hidden=YES;
}

-(void)btnLong:(UIGestureRecognizer *) sender{
   
    if([sender state]==UIGestureRecognizerStateBegan){
         NSLog(@"长按事件开始");
        [self startAnimation];
        [self.commonBtn setTitle:@"松开发送" forState:UIControlStateNormal];
        [[AudioRecord shareAudioRecord] startRecord];
    }
    
    if([sender state]==UIGestureRecognizerStateEnded){
        NSLog(@"长按事件结束");
        [[AudioRecord shareAudioRecord] stopRecord];
        [self stopAnimation];
        [self.commonBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [[AudioRecord shareAudioRecord] stopRecord];
        
        NSString *filePath=[[AudioRecord shareAudioRecord] audioRecordPath];
        NSLog(@"录音地址%@",filePath);
        NSData *fileData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMapped error:nil];
        NSLog(@"fileData%@",fileData);
//        [ServiceApi uploadForVoice:filePath accData:fileData success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"reponseObject===%@",responseObject);
//                        if([responseObject[@"ret"] intValue]==200 ){
//                            NSString *url=responseObject[@"remoteFileName"];
//                            //的到url之后回传个JSSDK 然后调H5方法
//                        }else{
//                            [YWindow XJShowToast:responseObject[@"msg"]];
//                        }
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [YWindow XJShowToast:@"上传失败"];
//        }];
        
    }
    
}

-(void)initImageAnimation{
    UIImage *image1 = [UIImage imageNamed:@"im_microphone1"];
    UIImage *image2 = [UIImage imageNamed:@"im_microphone2"];
    UIImage *image3 = [UIImage imageNamed:@"im_microphone3"];
    UIImage *image4 = [UIImage imageNamed:@"im_microphone4"];
    UIImage *image5 = [UIImage imageNamed:@"im_microphone5"];
    self.animeImageView.animationRepeatCount=0;//无限次重复
    self.animeImageView.image = [UIImage animatedImageWithImages:@[image1,image2,image3,image4,image5] duration:0.8f];
}
- (IBAction)play:(id)sender {
//    [[PlayRecord sharePlayRecord] playerRecord:@"http://wanxiangcheng365.cn/BangBang/upload/temp/tmp_20190330190657JAlsae.aac"];
    [[PlayRecord sharePlayRecord] playerRecord:@"https://www.aconvert.com/samples/sample.aac"];
}

@end
