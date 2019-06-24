//
//  DPHSelectImageVC.h
//  tzIMage
//
//  Created by Alien on 2017/8/28.
//  Copyright © 2017年 Alien. All rights reserved.
//

#import <UIKit/UIKit.h>

//有返回值，无参数
typedef void(^SelectedImageBlock)(NSArray<UIImage *> *images);
typedef void(^closeSelectImageView)(void);
@interface DPHSelectImageVC : UIViewController
//图片最大张数
@property(nonatomic, assign) NSInteger imageMaxNumber;
//是否允许裁剪图片
@property(nonatomic, assign) BOOL allowCrop;

@property(nonatomic, copy) SelectedImageBlock imageBlock;
@property(nonatomic, copy) closeSelectImageView closeBlock;
/**
 显示图片选择界面
 */
-(void)showSelectImageView;

@end
/**    单独使用方式
 
 DPHSelectImageVC *selectImageVC = [[DPHSelectImageVC alloc]init];
 //设置弹出的view是透明的
 selectImageVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
     // 在这里加一个这个样式的循环
     while (topRootViewController.presentedViewController)
     {
         // 这里固定写法
         topRootViewController = topRootViewController.presentedViewController;
     }
     // 然后再进行present操作
     [topRootViewController presentViewController:selectImageVC animated:YES completion:^{
         [selectImageVC showSelectImageView];
     }];
 //上传图片最大张数
 selectImageVC.imageMaxNumber = 1;
 selectImageVC.allowCrop = YES;
 //选中完成的block
 selectImageVC.imageBlock  = ^(NSArray<UIImage *> *images)
 {
 //
 //        self.userIconImageView.image = images.firstObject;
 XJLog(@"%@",images.firstObject);
 [self updateImage:images.firstObject];
 };
 
 */
