//
//  LoginViewController.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginModel.h"
#import "AppDelegate.h"
#import "RegisteredViewController.h"
#import "ForgetPwdViewController.h"//忘记密码
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//手机号
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;//密码
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdButton;//忘记密码
@property (weak, nonatomic) IBOutlet UIButton *registeredButton;//注册
@property (weak, nonatomic) IBOutlet UIButton *loginButton;//登录
@property (nonatomic,strong) LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLoginView];
    [self loginReceiveSignal];
//    self.phoneTextField.text = @"18410903896";
//    self.passwordTextField.text = @"111111";
}
#pragma mark   接收信号
-(void)loginReceiveSignal{
    //    注册新号接收网络请求回调
    [[self.viewModel.loginSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary*  _Nullable x) {
        XJLog(@"%@",x);
        LoginModel *model = [LoginModel yy_modelWithJSON:x[@"data"]];
        [[CacheUserInfo shareInstance] setCacheUserInfo:model.user];
        [[CacheUserInfo shareInstance] setCacheToken:model.token];
        AppDelegate *deleagate = (AppDelegate *)YAppDelegate;
        [deleagate mainTabBarRootVC];
    }];
}
#pragma mark      UI
-(void)configLoginView{
    self.navBarView.hidden = YES;
    [self.phoneTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    [[self.phoneTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 11; // 表示输入文字长度 > 1 时才会调用下面的 block
    }] subscribeNext:^(NSString * _Nullable x) {
        self.phoneTextField.text = [x substringWithRange:NSMakeRange(0,11)];
    }];
    
    
    [[self.forgetPwdButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [self.navigationController pushViewController:[ForgetPwdViewController new] animated:YES];
    }];
    [[self.registeredButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [self.navigationController pushViewController:[RegisteredViewController new] animated:YES];
    }];
    RAC(_loginButton, enabled) = [RACSignal combineLatest:@[self.phoneTextField.rac_textSignal, self.passwordTextField.rac_textSignal] reduce:^id _Nullable(NSString * phoneNumber, NSString * password){
        if(phoneNumber.length == 11 && password.length > 5){
            [self.loginButton setBackgroundImage:[UIImage imageNamed:@"Login_bule"] forState:UIControlStateNormal];
            [self.loginButton setTitleColor:XJWhiteColor forState:UIControlStateNormal];
        }else{
            [self.loginButton setBackgroundImage:[UIImage imageNamed:@"Login_gray"] forState:UIControlStateNormal];
            [self.loginButton setTitleColor:XJGrayColor forState:UIControlStateNormal];
        }
        return @(phoneNumber.length == 11 && password.length > 5);
    }];
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDictionary *paramDic = @{
                                   @"userName":self.phoneTextField.text,
                                   @"password":self.passwordTextField.text
                                   };
        //        发送信号
        [self.viewModel.loginCommand execute:paramDic];
    }];
}
- (LoginViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}
@end
