//
//  RegisteredViewController.m
//  IMNetworking
//
//  Created by 杨炯 on 2019/6/24.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "RegisteredViewController.h"
#import "RegisteViewModel.h"
@interface RegisteredViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *goLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;

@property (nonatomic, strong) RACDisposable *disposable;


@property (nonatomic,strong)RegisteViewModel *viewModel;
@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configRegisteredView];
    [self receiveSignal];
}

-(void)receiveSignal{
    [[self.viewModel.getCodeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary*  _Nullable x) {
        XJLog(@"code-------%@",x);
        [self countdown];
        
    }];
    
    [[self.viewModel.registeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary*  _Nullable x) {
        XJLog(@"registe------%@",x);

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

-(void)configRegisteredView{
    self.navBarView.hidden = YES;
    [self.phoneNumberTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneCodeTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:XJPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];


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
            [self countdown];
        }else{
            [YWindow XJShowToast:@"获取验证码"];
            [self.viewModel.getCodeSubject sendNext:@""];
        }
    }];
    [[self.goLoginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [[self.protocolButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [YWindow XJShowToast:@"同意协议"];
    }];
    
    
    
    RAC(_registButton, enabled) = [RACSignal combineLatest:@[self.phoneNumberTextField.rac_textSignal, self.phoneCodeTextField.rac_textSignal,self.pwdTextField.rac_textSignal] reduce:^id _Nullable(NSString * phoneNumber, NSString *code,NSString * password){
        if(phoneNumber.length == 11 && code.length == 6 && password.length > 5){
            [self.registButton setBackgroundImage:[UIImage imageNamed:@"Login_bule"] forState:UIControlStateNormal];
            [self.registButton setTitleColor:XJWhiteColor forState:UIControlStateNormal];
        }else{
            [self.registButton setBackgroundImage:[UIImage imageNamed:@"Login_gray"] forState:UIControlStateNormal];
            [self.registButton setTitleColor:XJGrayColor forState:UIControlStateNormal];
        }
        return @(phoneNumber.length == 11 && code.length == 6 && password.length > 5);
    }];
    [[self.registButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        去注册
        [self.viewModel.registeSubject sendNext:@""];

    }];
    
    
}
- (RegisteViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[RegisteViewModel alloc]init];
    }
    return _viewModel;
}
@end
