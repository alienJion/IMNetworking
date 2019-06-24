//
//  DPHSelectImageVC.m
//  tzIMage
//
//  Created by Alien on 2017/8/28.
//  Copyright © 2017年 Alien. All rights reserved.
//

#import "DPHSelectImageVC.h"//相册图片选择
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "UIImage+FixOrientation.h"

@interface DPHSelectImageVC ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) TZImagePickerController *imagePickerVc;
@end

@implementation DPHSelectImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
/**
 显示图片选择界面
 */
-(void)showSelectImageView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openImage];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(self.closeBlock){
            self.closeBlock();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 显示图片
 */
-(void)openImage{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted||status == PHAuthorizationStatusDenied) {
        //未开启访问相册的权限
        //引导用户开启访问相册权限
        UIAlertController *alertConyroller = [UIAlertController alertControllerWithTitle:@"相册功能未开启" message:@"您需要在系统设置中打开相册进行授权" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alertConyroller addAction:cancelAction];
        [alertConyroller addAction:setAction];
        [self presentViewController:alertConyroller animated:YES completion:nil];
        
    }else{
        
        self.imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_imageMaxNumber delegate:self];
        self.imagePickerVc.naviBgColor = XJMainColor;
        self.imagePickerVc.naviTitleColor = XJWhiteColor;
        self.imagePickerVc.barItemTextColor = XJWhiteColor;
        // 自定义导航栏上的返回按钮
        [self.imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
            [leftButton setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
            [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
        }];
        if (self.allowCrop) {
            self.imagePickerVc.allowCrop = YES;
            self.imagePickerVc.cropRect = CGRectMake(0, (YScreenHeight-YScreenWidth)/2, YScreenWidth, YScreenWidth);
        }
        self.imagePickerVc.allowTakePicture = NO;
        self.imagePickerVc.autoDismiss = NO;
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        WeakSelf(weakSelf);
        [self.imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
            if (weakSelf.imageBlock) {
                weakSelf.imageBlock(photos);
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        //        [self presentViewController:self.imagePickerVc animated:YES completion:nil];
        
        [self addChildViewController:self.imagePickerVc];
        [self.view addSubview:self.imagePickerVc.view];
    }
}

///**
// 关闭TZImagePickerController后
// */
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    if(self.closeBlock){
        self.closeBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIImagePickerController
/**
 打开相机
 */
- (void)takePhoto {
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted||authStatus == AVAuthorizationStatusDenied){//已开启相机权限
        //引导用户开启访问相机权限
        UIAlertController *alertConyroller = [UIAlertController alertControllerWithTitle:@"相机功能未开启" message:@"您需要在系统设置中打开相机进行授权" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alertConyroller addAction:cancelAction];
        [alertConyroller addAction:setAction];
        [self presentViewController:alertConyroller animated:YES completion:nil];
    }else{
        
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        //相机
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerVC.delegate = self;
        [self addChildViewController:imagePickerVC];
        [self.view addSubview:imagePickerVC.view];
    }
}

/**
 选择图片成功调用此方法
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if(self.imageBlock){
        // 选择的图片信息存储于info字典中
        NSArray *imageArray = @[info[@"UIImagePickerControllerOriginalImage"]];
        NSMutableArray *imageMutableArray = [NSMutableArray arrayWithCapacity:0];
        for (UIImage *image in imageArray) {
            [imageMutableArray addObject:[image normalizedImage]];
        }
        
        self.imageBlock(imageMutableArray);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 取消图片选择调用此方法
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // dismiss UIImagePickerController
    if(self.closeBlock){
        self.closeBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

