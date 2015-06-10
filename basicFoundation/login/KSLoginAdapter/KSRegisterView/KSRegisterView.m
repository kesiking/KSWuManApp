//
//  KSRegisterView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSRegisterView.h"
#import "KSLoginComponentItem.h"
#import "MWUtils.h"

#define account_label_description  @"账户"
#define password_label_description @"登陆密码"

#define text_label_width (caculateNumber(65.0))

@interface KSRegisterView()

@end

@implementation KSRegisterView

-(void)setupView{
    [super setupView];
    [self initRegisterViewCtl];
    [self reloadData];
}

-(void)initRegisterViewCtl{
    self.registerViewCtl.logo_imgView.hidden = NO;
    self.registerViewCtl.text_phoneNum.hidden = NO;
    self.registerViewCtl.text_psw.hidden = NO;
    self.registerViewCtl.smsCodeView.hidden = NO;
    self.registerViewCtl.btn_register.hidden = NO;
    [self addSubview:self.registerViewCtl];
}

-(void)reloadData{

}

-(void)setRegisterService:(KSLoginService *)registerService{
    if (_registerService != registerService) {
        _registerService = nil;
        _registerService = registerService;
        [self setupRegisterService];
    }
}

-(KSLoginService *)getRegisterService{
    if (_registerService == nil) {
        _registerService = [[KSLoginService alloc] init];
        [self setupRegisterService];
    }
    return _registerService;
}

-(void)setupRegisterService{
    WEAKSELF
    _registerService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
        STRONGSELF
        if (strongSelf.registerActionBlock) {
            strongSelf.registerActionBlock(YES);
        }
    };
    
    _registerService.serviceDidFailLoadBlock = ^(WeAppBasicService* service , NSError* error){
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
    };
}

-(KSLoginService *)getValidateCodeService{
    if (_validateCodeService == nil) {
        _validateCodeService = [[KSLoginService alloc] init];
        [self setupValidateCodeServcie];
    }
    return _validateCodeService;
}

-(void)setValidateCodeService:(KSLoginService *)validateCodeService{
    if (_validateCodeService != validateCodeService) {
        _validateCodeService = nil;
        _validateCodeService = validateCodeService;
        [self setupValidateCodeServcie];
    }
}

-(void)setupValidateCodeServcie{
    WEAKSELF
    _validateCodeService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
        STRONGSELF
        [WeAppToast toast:@"验证码已发送"];
    };
    
    _validateCodeService.serviceDidFailLoadBlock = ^(WeAppBasicService* service , NSError* error){
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
    };
}

-(void)setRegisterViewCtl:(KSRegisterViewCtl *)registerViewCtl{
    if (_registerViewCtl != registerViewCtl) {
        _registerViewCtl = nil;
        _registerViewCtl = registerViewCtl;
        [self setupRegisterViewCtl];
    }
}

-(KSRegisterViewCtl *)getRegisterViewCtl{
    if (_registerViewCtl == nil) {
        _registerViewCtl = [[KSRegisterViewCtl alloc] initWithFrame:self.bounds];
        [self setupRegisterViewCtl];
    }
    return _registerViewCtl;
}

-(void)setupRegisterViewCtl{
    WEAKSELF
    _registerViewCtl.registerBlock = ^(KSRegisterViewCtl* registerViewCtl){
        STRONGSELF
        if(![MWUtils isValidMobile:registerViewCtl.text_phoneNum.text])
        {
            [WeAppToast toast:@"请输入正确的手机号"];
            return;
        }else if(registerViewCtl.text_smsCode.text.length == 0)
        {
            [WeAppToast toast:@"请输入验证码"];
            return;
        }
        if(![MWUtils isValidPassword:registerViewCtl.text_psw.text])
        {
            [WeAppToast toast:@"请输入密码"];
            return;
        }
        
        [strongSelf.registerService registerWithAccountName:registerViewCtl.text_phoneNum.text password:registerViewCtl.text_psw.text userName:registerViewCtl.text_userName.text validateCode:registerViewCtl.text_smsCode.text inviteCode:registerViewCtl.text_inviteCode.text];
    };
    
    _registerViewCtl.cancelRegisterBlock = ^(KSRegisterViewCtl* registerViewCtl){
        STRONGSELF
        if (strongSelf.cancelActionBlock) {
            strongSelf.cancelActionBlock();
        }
    };
    
    _registerViewCtl.getValidateColdBlock = ^(KSValidateCodeViewCtl* registerViewCtl){
        STRONGSELF
        if(![MWUtils isValidMobile:((KSRegisterViewCtl*)registerViewCtl).text_phoneNum.text])
        {
            [WeAppToast toast:@"请输入正确的手机号"];
            return NO;
        }
        [strongSelf.getValidateCodeService sendValidateCodeWithAccountName:((KSRegisterViewCtl*)registerViewCtl).text_phoneNum.text];
        return YES;
    };
}

@end
