//
//  KSRegisterViewCtl.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSRegisterViewCtl.h"

#define register_width  (self.frame.size.width - kSpaceX * 2)
#define view_width      (self.frame.size.width)

#define text_height     (40.0)
#define text_border     (8.0)

@interface KSRegisterViewCtl()<UITextFieldDelegate>

@property (nonatomic, assign) CGRect       frame;

@end

@implementation KSRegisterViewCtl

-(id)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
}

- (UIImageView *)logo_imgView
{
    if(!_logo_imgView)
    {
        _logo_imgView = [[UIImageView alloc]initWithFrame:CGRectMake((view_width - 60)/2, 30, 60, 60)];
        _logo_imgView.backgroundColor = [UIColor redColor];
    }
    return _logo_imgView;
}

- (WeAppBasicFieldView *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [[WeAppBasicFieldView alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_logo_imgView.frame) + 30, register_width, text_height)];
        _text_phoneNum.textView.placeholder = @"手机号码";
        [_text_phoneNum.textView setFont:[UIFont systemFontOfSize:16]];
        _text_phoneNum.textView.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_phoneNum.textView.keyboardType = UIKeyboardTypeNumberPad;
        _text_phoneNum.textView.clearButtonMode = UITextFieldViewModeAlways;
        _text_phoneNum.textView.secureTextEntry = NO;
        [_text_phoneNum setBackgroundColor:[UIColor clearColor]];
    }
    return _text_phoneNum;
}

- (WeAppBasicFieldView *)text_psw
{
    if(!_text_psw)
    {
        _text_psw = [[WeAppBasicFieldView alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_phoneNum.frame) + text_border, register_width, text_height)];
        _text_psw.textView.placeholder = @"密码";
        [_text_psw.textView setFont:[UIFont systemFontOfSize:16]];
        _text_psw.textView.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_psw.textView.keyboardType = UIKeyboardTypeNamePhonePad;
        _text_psw.textView.clearButtonMode = UITextFieldViewModeAlways;
        _text_psw.textView.secureTextEntry = YES;
        [_text_psw setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_psw;
}

- (UIView *)smsCodeView
{
    if(!_smsCodeView)
    {
        _smsCodeView = [[UIView alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_psw.frame) + text_border, register_width, text_height)];
        _smsCodeView.backgroundColor = [UIColor whiteColor];
        
        [_smsCodeView addSubview:self.text_smsCode];
        
        [_smsCodeView addSubview:self.btn_smsCode];
        
    }
    
    return _smsCodeView;
}

-(WeAppBasicFieldView *)text_smsCode{
    if (!_text_smsCode) {
        _text_smsCode = [[WeAppBasicFieldView alloc]initWithFrame:CGRectMake(0, 0, (register_width)/2 + 20, text_height)];
        _text_smsCode.textView.placeholder = @"验证码";
        [_text_smsCode.textView setFont:[UIFont systemFontOfSize:16]];
        _text_smsCode.textView.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_smsCode.textView.keyboardType = UIKeyboardTypeNumberPad;
        _text_smsCode.textView.clearButtonMode = UITextFieldViewModeAlways;
        _text_smsCode.textView.secureTextEntry = YES;
        [_text_smsCode setBackgroundColor:[UIColor clearColor]];
    }
    return _text_smsCode;
}

-(UIButton *)btn_smsCode{
    if (!_btn_smsCode) {
        _btn_smsCode = [[UIButton alloc]initWithFrame:CGRectMake((register_width)/2 + 20, 0, (register_width)/2 - 20, text_height)];
        [_btn_smsCode setTitle:@"获取验证码"forState:UIControlStateNormal];
        _btn_smsCode.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btn_smsCode setBackgroundColor:[UIColor colorWithRed:0xb9/255.0 green:0xb9/255.0 blue:0xb9/255.0 alpha:1.0]];
        [_btn_smsCode addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_smsCode;
}

- (WeAppBasicFieldView *)text_inviteCode
{
    if(!_text_inviteCode)
    {
        _text_inviteCode = [[WeAppBasicFieldView alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_psw.frame) + text_border, register_width, text_height)];
        _text_inviteCode.textView.placeholder = @"邀请码";
        [_text_inviteCode.textView setFont:[UIFont systemFontOfSize:16]];
        _text_inviteCode.textView.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _text_inviteCode.textView.keyboardType = UIKeyboardTypeNumberPad;
        _text_inviteCode.textView.clearButtonMode = UITextFieldViewModeAlways;
        _text_inviteCode.textView.secureTextEntry = NO;
        [_text_inviteCode setBackgroundColor:[UIColor clearColor]];
    }
    return _text_inviteCode;
}

- (WeAppBasicFieldView *)text_userName
{
    if(!_text_userName)
    {
        _text_userName = [[WeAppBasicFieldView alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_inviteCode.frame) + text_border, register_width, text_height)];
        _text_userName.textView.placeholder = @"用户名";
        [_text_userName.textView setFont:[UIFont systemFontOfSize:16]];
        _text_userName.textView.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _text_userName.textView.keyboardType = UIKeyboardTypeNumberPad;
        _text_userName.textView.clearButtonMode = UITextFieldViewModeAlways;
        _text_userName.textView.secureTextEntry = NO;
        [_text_userName setBackgroundColor:[UIColor clearColor]];
    }
    return _text_userName;
}

- (UIButton *)btn_register
{
    if(!_btn_register)
    {
        _btn_register = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_smsCodeView.frame) + 30, register_width, text_height)];
        _btn_register.layer.cornerRadius = 4;
        _btn_register.layer.masksToBounds = YES;
        [_btn_register setTitle:@"注册" forState:UIControlStateNormal];
        _btn_register.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn_register.titleLabel.textColor = [UIColor whiteColor];
        [_btn_register setBackgroundColor:[UIColor colorWithRed:0xdc/255.0 green:0x78/255.0 blue:0x68/255.0 alpha:1.0]];
        
        [_btn_register addTarget:self action:@selector(registerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_register;
}

- (void)cancelRegister
{
    if (self.cancelRegisterBlock) {
        self.cancelRegisterBlock(self);
    }
}

- (void)getValidateCode
{
    BOOL canGetValidateCode = NO;
    
    if (self.getValidateColdBlock) {
        canGetValidateCode = self.getValidateColdBlock(self);
    }
    
    if (!canGetValidateCode) {
        return;
    }
    
    [self showSecondTimeout:self.smsCodeSeconds > 0 ?:90 target:self timerOutAction:@selector(updateUIWhenSecondTimeout:)];
    
}

- (void)registerButtonTapped
{
    if (self.registerBlock) {
        self.registerBlock(self);
    }
}

#pragma mark - helper functions
- (void)updateUIWhenSecondTimeout:(NSDictionary*)userinfo
{
    BOOL bEnd = [[userinfo objectForKey:@"timerend"] boolValue];
    if (bEnd)
    {
        _btn_smsCode.enabled = YES;
        //设置界面的按钮显示
        [_btn_smsCode setBackgroundColor:[UIColor colorWithRed:0xb9/255.0 green:0xb9/255.0 blue:0xb9/255.0 alpha:1.0]];
        [_btn_smsCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        NSUInteger remainTime = [[userinfo objectForKey:@"remaintime"] unsignedIntegerValue];
        NSString *strTime = [NSString stringWithFormat:@"%lus后重新获取",(unsigned long)remainTime];
        
        _btn_smsCode.enabled = NO;
        //设置界面的按钮显示
        [_btn_smsCode setBackgroundColor:[UIColor redColor]];
        [_btn_smsCode setTitle:strTime forState:UIControlStateDisabled];
    }
}

- (void)showSecondTimeout:(NSUInteger)time target:(id)target timerOutAction:(SEL)action
{
    __block NSUInteger timeout= time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //没秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            //            dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithBool:YES] forKey:@"timerend"];
                [target performSelector:action withObject:userInfo];
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithBool:NO] forKey:@"timerend"];
                [userInfo setObject:[NSNumber numberWithUnsignedInteger:timeout] forKey:@"remaintime"];
                [target performSelector:action withObject:userInfo];
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

@end
