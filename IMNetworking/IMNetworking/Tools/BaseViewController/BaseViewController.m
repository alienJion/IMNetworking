//
//  BaseViewController.m
//  HappyShopping
//
//  Created by Alien on 2018/10/23.
//  Copyright © 2018 alien. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property(nonatomic,strong)UIButton *itemButton;

@end

@implementation BaseViewController
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//使用FDFullscreenPopGesture库隐藏导航栏
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;//需要显示系统自带导航栏的时候重写该方法。返回YES
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor = bgColor;
    [self customNavViewLeftBarButtonItem:^(UIButton * _Nonnull itemButton) {
        [itemButton setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    }];
    
}
//视图已经出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navBarView];
}

#pragma mark-----------Request-------------
#pragma mark-----------Delegate------------
#pragma mark-----------UI------------------
-(UIView *)navBarView{
    if (_navBarView == nil) {
        _navBarView = [[UIView alloc]init];
        [self.view addSubview:_navBarView];
        if (self.navigationBGColor) {
            _navBarView.backgroundColor = self.navigationBGColor;
        }else{
            _navBarView.backgroundColor = mainColor;
        }
        [_navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            make.height.offset(YTopNavHight);
        }];
    }
    return _navBarView;
}
-(void)showNavViewButtomLien{
    UIView *lienView = [[UIView alloc]init];
    lienView.backgroundColor = bgColor;
    [self.navBarView addSubview:lienView];
    [lienView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(1);
    }];
}
/**
 左边button
 @param buttonBlock 具有UIBarButtonItem参数的block
 */
-(void)customNavViewLeftBarButtonItem:(void(^)(UIButton *itemButton))buttonBlock{
    if (buttonBlock) {
        UIButton *btn = [self.navBarView viewWithTag:123];
        if (btn == nil) {
            btn = [self itemButton];
            btn.tag = 123;
            [btn addTarget:self action:@selector(leftButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(3);
                make.top.offset(YTopStatusHeight);
                make.width.height.offset(44);
            }];
        }
        buttonBlock(btn);
    }
}
/**
 中间button
 */
-(void)customNavViewCenterButtonItem:(void(^)(UIButton *itemButton))buttonBlock{
    if (buttonBlock) {
        UIButton *btn = [self.navBarView viewWithTag:456];
        if (btn == nil) {
            btn = [self itemButton];
            btn.tag = 456;
            [btn addTarget:self action:@selector(centerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
            btn.center = CGPointMake(YScreenWidth/2, btn.center.y);
            [self.navBarView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(49);
                make.top.offset(YTopStatusHeight + 5);
                make.width.offset(YScreenWidth - 49 * 2);
                make.bottom.offset(-5);
            }];
        }
        buttonBlock(btn);
    }
}
/**
 中间view
 */
-(void)customNavViewCenterTitleView:(void(^)(UIView *titleView))titleViewBlock{
    UIView *titleView = [self.navBarView viewWithTag:147];
    if (titleView == nil) {
        titleView = [[UIView alloc]init];
        titleView.tag = 147;
        titleView.center = CGPointMake(YScreenWidth/2, titleView.center.y);
        titleView.backgroundColor = [UIColor clearColor];
        [self.navBarView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(49);
            make.top.offset(YTopStatusHeight + 5);
            make.width.offset(YScreenWidth - 49 * 2);
            make.bottom.offset(-5);
        }];
    }
    titleViewBlock(titleView);
}
/**
 右边button
 */
-(void)customNavViewRightBarButtonItem:(void(^)(UIButton *itemButton))buttonBlock{
    UIButton *btn = [self.navBarView viewWithTag:789];
    if (btn == nil) {
        btn = [self itemButton];
        btn.tag = 789;
        btn.titleLabel.font = YFontSize16;
        [btn addTarget:self action:@selector(rightButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBarView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-3);
            make.top.offset(YTopStatusHeight);
            make.width.height.offset(44);
        }];
    }
    buttonBlock(btn);
}

#pragma mark-----------Action--------------
-(void)leftButtonEvent:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)centerButtonEvent:(UIButton *)btn{
    
}
-(void)rightButtonEvent:(UIButton *)btn{

}
#pragma mark-----------Func----------------
-(UIButton *)itemButton{
    _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemButton setTitleColor:YWhiteColor forState:UIControlStateNormal];
    _itemButton.titleLabel.font = YFontSize18;
    return _itemButton;
}
- (void)setTitle:(NSString *)title{
    if (title.length > 0) {
        [self customNavViewCenterButtonItem:^(UIButton * _Nonnull itemButton) {
            [itemButton setTitle:title forState:UIControlStateNormal];
        }];
    }
}
-(void)setRightBarTitle:(NSString *)rightBarTitle{
    if (rightBarTitle.length > 0) {
        [self customNavViewRightBarButtonItem:^(UIButton * _Nonnull itemButton) {
            [itemButton setTitle:rightBarTitle forState:UIControlStateNormal];
        }];
    }
}
@end
