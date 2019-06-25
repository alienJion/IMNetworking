//
//  ForgetPwdViewController.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/25.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ForgetPwdViewController.h"//忘记密码
#import "UpdatePwdViewModel.h"

@interface ForgetPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (nonatomic, strong) RACDisposable *disposable;

@property (nonatomic, strong) UpdatePwdViewModel *viewModel;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configForgetPwdView];
    [self receiveSignal];
}
-(void)receiveSignal{
    [[self.viewModel.getCodeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary*  _Nullable x) {
        XJLog(@"code-------%@",x);
        [self countdown];

    }];

    [[self.viewModel.updatePwdSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary*  _Nullable x) {
        XJLog(@"registe------%@",x);

    }];
}


-(void)configForgetPwdView{
    self.navBarView.hidden = YES;
    [self.phoneNumberTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneCodeTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.verifyPwdTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    [[self.phoneNumberTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 11;
    }] subscribeNext:^(NSString * _Nullable x) {
        self.phoneNumberTextField.text = [x substringWithRange:NSMakeRange(0,11)];
    }];
    [[self.phoneCodeTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        self.phoneCodeTextField.text = [x substringWithRange:NSMakeRange(0,6)];
    }];
    
    [[self.phoneCodeTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        self.phoneCodeTextField.text = [x substringWithRange:NSMakeRange(0,6)];
    }];
    
    
    [[self.codeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        if(self.phoneNumberTextField.text.length != 11){
            [YWindow XJShowToast:@"请核对手机号"];
        }else{
//            [YWindow XJShowToast:@"获取验证码"];
            NSDictionary *para = @{@"phone" : [NSString nullToString:self.phoneNumberTextField.text]};
            [self.viewModel.getCodeCommand execute:para];
        }
    }];
    
    
    RAC(_commitButton, enabled) = [RACSignal combineLatest:@[self.phoneNumberTextField.rac_textSignal, self.phoneCodeTextField.rac_textSignal,self.pwdTextField.rac_textSignal,self.verifyPwdTextField.rac_textSignal] reduce:^id _Nullable(NSString * phoneNumber, NSString *code,NSString * password,NSString *verifyStr){
        if(phoneNumber.length && code.length && password.length && verifyStr.length ){
            [self.commitButton setBackgroundImage:[UIImage imageNamed:@"Login_bule"] forState:UIControlStateNormal];
            [self.commitButton setTitleColor:XJWhiteColor forState:UIControlStateNormal];
        }else{
            [self.commitButton setBackgroundImage:[UIImage imageNamed:@"Login_gray"] forState:UIControlStateNormal];
            [self.commitButton setTitleColor:XJGrayColor forState:UIControlStateNormal];
        }
        return @(phoneNumber.length && code.length && password.length && verifyStr.length);
    }];
    [[self.commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.pwdTextField.text.length != 11) {
            [YWindow XJShowToast:@"请核对手机号"];
            return ;
        }
        if (self.phoneCodeTextField.text.length != 6) {
            [YWindow XJShowToast:@"请输入六位验证码"];
            return ;
        }
        if (self.pwdTextField.text.length < 6 && self.pwdTextField.text.length > 20) {
            [YWindow XJShowToast:@"请输入6-20位密码"];
            return ;
        }
        if (![self.pwdTextField.text isEqualToString:self.verifyPwdTextField.text]) {
            [YWindow XJShowToast:@"请核对两次密码是否一致"];
            return ;
        }
        NSDictionary *para = @{
                               @"userName" : [NSString nullToString:self.phoneNumberTextField.text],
                               @"verifyCode" : [NSString nullToString:self.phoneCodeTextField.text],
                               @"newPassword" : [NSString nullToString:self.pwdTextField.text],
                               @"confirmPassword" : [NSString nullToString:self.verifyPwdTextField.text],
                               };
        [self.viewModel.updatePwdCommand execute:para];
    }];
    
    
}

-(void)countdown{
    /* 定义计时器监听 */
    __block int timeCode = 60;
    self.codeButton.userInteractionEnabled = NO;
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"当前时间：%@", x); // x 是当前的系统时间
        timeCode --;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%ds",timeCode] forState:UIControlStateNormal];
        if (timeCode == 0) {
            self.codeButton.userInteractionEnabled = YES;
            [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self->_disposable dispose];/* 关闭计时器 */
        }
    }];
}
-(UpdatePwdViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[UpdatePwdViewModel alloc]init];
    }
    return _viewModel;
}
@end
