//
//  KSLoginView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginView.h"
#import "KSLoginKeyChain.h"
#import "KSLoginComponentItem.h"
#import "KSLoginUrlPath.h"
#import "MWUtils.h"

#define account_label_description  @"账户"
#define password_label_description @"登陆密码"

#define text_label_width (caculateNumber(65.0))

@interface KSLoginView()

@end

@implementation KSLoginView

-(void)setupView{
    [super setupView];
    [self initLoginViewCtl];
    [self configTextView];
    [self reloadData];
}

-(void)initLoginViewCtl{
    self.loginViewCtl.logo_imgView.hidden = NO;
    self.loginViewCtl.text_phoneNum.hidden = NO;
    self.loginViewCtl.text_psw.hidden = NO;
    self.loginViewCtl.btn_forgetPwd.hidden = NO;
    self.loginViewCtl.btn_login.hidden = NO;
    [self addSubview:self.loginViewCtl];
}

-(void)configTextView{
    UILabel *account_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, text_label_width, self.loginViewCtl.text_phoneNum.height)];
    account_label.textAlignment = NSTextAlignmentLeft;
    account_label.text = account_label_description;
    account_label.font = [UIFont systemFontOfSize:16];
    self.loginViewCtl.text_phoneNum.textView.leftView = account_label;
    self.loginViewCtl.text_phoneNum.textView.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *password_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, text_label_width, self.loginViewCtl.text_phoneNum.height)];
    password_label.textAlignment = NSTextAlignmentLeft;
    password_label.text = password_label_description;
    password_label.font = [UIFont systemFontOfSize:16];
    password_label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.loginViewCtl.text_psw.textView.leftView = password_label;
    self.loginViewCtl.text_psw.textView.leftViewMode = UITextFieldViewModeAlways;
}

-(void)reloadData{
    self.loginViewCtl.text_phoneNum.text = [[KSLoginComponentItem sharedInstance] getAccountName];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.loginViewCtl.text_phoneNum.textView.leftView setHeight:self.loginViewCtl.text_phoneNum.height];
    [self.loginViewCtl.text_psw.textView.leftView setHeight:self.loginViewCtl.text_psw.height];
}

-(void)setService:(KSLoginService *)service{
    if (_service != service) {
        _service = nil;
        _service = service;
        [self setupService];
    }
}

-(KSLoginService *)getService{
    if (_service == nil) {
        _service = [[KSLoginService alloc] init];
        [self setupService];
    }
    return _service;
}

-(void)setupService{
    WEAKSELF
    _service.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
        STRONGSELF
        if (strongSelf.loginActionBlock) {
            strongSelf.loginActionBlock(YES);
        }
    };
    
    _service.serviceDidFailLoadBlock = ^(WeAppBasicService* service , NSError* error){
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
    };
}

-(void)setLoginViewCtl:(KSLoginViewCtl *)loginViewCtl{
    if (_loginViewCtl != loginViewCtl) {
        _loginViewCtl = nil;
        _loginViewCtl = loginViewCtl;
        [self setupLoginViewCtl];
    }
}

-(KSLoginViewCtl *)getLoginViewCtl{
    if (_loginViewCtl == nil) {
        _loginViewCtl = [[KSLoginViewCtl alloc] initWithFrame:self.bounds];
        [self setupLoginViewCtl];
    }
    return _loginViewCtl;
}

-(void)setupLoginViewCtl{
    WEAKSELF
    _loginViewCtl.loginBlock = ^(KSLoginViewCtl* loginViewCtl){
        STRONGSELF
        if(![MWUtils isValidMobile:loginViewCtl.text_phoneNum.text])
        {
            [WeAppToast toast:@"请输入正确的手机号"];
            return;
        }else if(![MWUtils isValidPassword:loginViewCtl.text_psw.text])
        {
            [WeAppToast toast:@"请输入密码"];
            return;
        }
        
        [strongSelf.service loginWithAccountName:loginViewCtl.text_phoneNum.text password:loginViewCtl.text_psw.text];
    };
    
    _loginViewCtl.cancelLoginBlock = ^(KSLoginViewCtl* loginViewCtl){
        STRONGSELF
        if (strongSelf.cancelActionBlock) {
            strongSelf.cancelActionBlock();
        }
    };
    
    _loginViewCtl.registerBlock = ^(KSLoginViewCtl* loginViewCtl){
        STRONGSELF
        TBOpenURLFromSourceAndParams(internalURL(kRegisterView), strongSelf, nil);
    };
    
    _loginViewCtl.resetPwdBlock = ^(KSLoginViewCtl* loginViewCtl){
        STRONGSELF
        TBOpenURLFromSourceAndParams(internalURL(kResetPwdPage), strongSelf, nil);
    };
}

@end
