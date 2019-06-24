//
//  MainTabBarController.h
//  MedicineStore
//
//  Created by  zhanglixiang on 16/5/18.
//  Copyright © 2016年 zhanglixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController
/**
 设置标签
 
 @param vcsArray 对应的viewController数组
 @param vcTitleArray 对应标题名称
 @param defaultImageArray 默认显示图片数组
 @param selectImageArray 选中图片数组
 */
-(void)setViewControllers:(NSArray *)vcsArray
     viewControllerTitleS:(NSArray *)vcTitleArray
            defaultImages:(NSArray *)defaultImageArray
           selectedImages:(NSArray *)selectImageArray;


/**
 设置制定item的角标

 @param tabbarIndex item下标
 @param itemNumber 要显示的个数
 */
+(void)configTabbar:(NSInteger)tabbarIndex ItemNumber:(NSInteger)itemNumber;

@end

