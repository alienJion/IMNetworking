//
//  BaseViewController.h
//  HappyShopping
//
//  Created by Alien on 2018/10/23.
//  Copyright © 2018 alien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UIView *navBarView;
/**
 右边按钮文字
 */
@property(nonatomic,strong)NSString *rightBarTitle;
/**
 左边button
 @param buttonBlock 具有UIBarButtonItem参数的block
 */
-(void)customNavViewLeftBarButtonItem:(void(^)(UIButton *itemButton))buttonBlock;
/**
 中间button
 */
-(void)customNavViewCenterButtonItem:(void(^)(UIButton *itemButton))buttonBlock;
/**
 中间view
 */
-(void)customNavViewCenterTitleView:(void(^)(UIView *titleView))titleViewBlock;
/**
 右边button
 */
-(void)customNavViewRightBarButtonItem:(void(^)(UIButton *itemButton))buttonBlock;
/**显示分割线*/
-(void)showNavViewButtomLien;
/**设置导航栏背景颜色*/
@property(nonatomic,strong)UIColor *navigationBGColor;
@end

NS_ASSUME_NONNULL_END
