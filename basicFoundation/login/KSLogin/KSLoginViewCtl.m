//
//  KSLoginViewCtl.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginViewCtl.h"
#import "KSLoginMaroc.h"

#define login_width (self.frame.size.width - kSpaceX * 2)
#define view_width (self.frame.size.width)

#define text_height     (40.0)
#define text_border     (8.0)

@interface KSLoginViewCtl()<UITextFieldDelegate>

@end

@implementation KSLoginViewCtl

-(id)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
}

-(UIButton *)btn_register{
    if (!_btn_register) {
        _btn_register = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_register.frame = CGRectMake(view_width - 50, 25, 40, 34);
        _btn_register.layer.cornerRadius = 2;
        _btn_register.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn_register.clipsToBounds = YES;
        _btn_register.userInteractionEnabled = YES;
        [_btn_register setTitle:@"注册" forState:UIControlStateNormal];
        [_btn_register setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_register addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_register;
}

-(UIButton *)btn_cancel{
    if (!_btn_cancel) {
        _btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_cancel.frame = CGRectMake(10, 25, 40, 34);
        _btn_cancel.layer.cornerRadius = 2;
        _btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn_cancel.clipsToBounds = YES;
        _btn_cancel.userInteractionEnabled = YES;
        [_btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btn_cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_cancel addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_cancel;
}

- (UIImageView *)logo_imgView
{
    if(!_logo_imgView)
    {
        _logo_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(view_width/2 - 30, 30, 60, 60)];
        _logo_imgView.backgroundColor = [UIColor whiteColor];
        _logo_imgView.opaque = YES;
        [self addSubview:_logo_imgView];
    }
    return _logo_imgView;
}

- (WeAppBasicFieldView *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [WeAppBasicFieldView getCommonFieldView];
        _text_phoneNum.textView.placeholder = @"手机号码/用户名";
        [self addSubview:_text_phoneNum];
    }
    return _text_phoneNum;
}

- (WeAppBasicFieldView *)text_psw
{
    if(!_text_psw)
    {
        _text_psw = [WeAppBasicFieldView getSecurityFieldView];
        _text_psw.textView.placeholder = @"密码";
        [self addSubview:_text_psw];
    }
    return _text_psw;
}

- (UIButton *)btn_forgetPwd
{
    if(!_btn_forgetPwd)
    {
        _btn_forgetPwd = [[UIButton alloc]initWithFrame:CGRectMake(view_width-kSpaceX-80, CGRectGetMaxY(_text_psw.frame) + 15, 80, 15)];
        [_btn_forgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_btn_forgetPwd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_forgetPwd setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_btn_forgetPwd.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _btn_forgetPwd.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn_forgetPwd addTarget:self action:@selector(doResetPwd) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_forgetPwd];
    }
    
    return _btn_forgetPwd;
}

- (UIButton *)btn_login
{
    if(!_btn_login)
    {
        _btn_login = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_btn_forgetPwd.frame) + 20, login_width, text_height)];
        _btn_login.layer.cornerRadius = 5;
        _btn_login.layer.masksToBounds = YES;
        [_btn_login setTitle:@"登录" forState:UIControlStateNormal];
        [_btn_login.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_login.titleLabel.textColor = [UIColor whiteColor];
        [_btn_login setBackgroundColor:[UIColor colorWithRed:0xdc/255.0 green:0x78/255.0 blue:0x68/255.0 alpha:1.0]];
        [_btn_login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_login];
    }
    
    return _btn_login;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _logo_imgView.frame = CGRectMake(view_width/2 - 30, 30, 60, 60);
    _text_phoneNum.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_logo_imgView.frame) + 30, login_width, text_height);
    _text_psw.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_text_phoneNum.frame) + text_border, login_width, text_height);
    _btn_forgetPwd.frame = CGRectMake(view_width-kSpaceX-80, CGRectGetMaxY(_text_psw.frame) + 15, 80, 15);
    _btn_login.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_btn_forgetPwd.frame) + 20, login_width, text_height);
}

- (void)login
{
    if (self.loginBlock) {
        self.loginBlock(self);
    }
}

- (void)doRegister
{
    if (self.registerBlock) {
        self.registerBlock(self);
    }
}

- (void)doResetPwd
{
    if (self.resetPwdBlock) {
        self.resetPwdBlock(self);
    }
}

- (void)cancelLogin
{
    if (self.cancelLoginBlock) {
        self.cancelLoginBlock(self);
    }
}

-(void)dealloc{
    self.loginBlock = nil;
    self.resetPwdBlock = nil;
    self.registerBlock = nil;
    self.cancelLoginBlock = nil;
}

@end
