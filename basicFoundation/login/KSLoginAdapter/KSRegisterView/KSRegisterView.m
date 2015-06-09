//
//  KSRegisterView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSRegisterView.h"
#import "KSLoginComponentItem.h"
#import "KSLoginService.h"
#import "MWUtils.h"

#define account_label_description  @"账户"
#define password_label_description @"登陆密码"

#define text_label_width (caculateNumber(65.0))

@interface KSRegisterView()

@property (nonatomic, strong) KSLoginService    *registerService;

@property (nonatomic, strong) KSLoginService    *getValidateCodeService;

@end

@implementation KSRegisterView

-(void)setupView{
    [super setupView];
    [self initRegisterViewCtl];
    [self reloadData];
}

-(void)initRegisterViewCtl{
    [self addSubview:self.registerViewCtl.logo_imgView];
    [self addSubview:self.registerViewCtl.text_phoneNum];
    [self addSubview:self.registerViewCtl.text_psw];
    [self addSubview:self.registerViewCtl.smsCodeView];
//    [self addSubview:self.registerViewCtl.text_inviteCode];
//    [self addSubview:self.registerViewCtl.text_userName];
    [self addSubview:self.registerViewCtl.btn_register];
}

-(void)reloadData{

}

-(KSLoginService *)registerService{
    if (_registerService == nil) {
        _registerService = [[KSLoginService alloc] init];
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
    return _registerService;
}

-(KSLoginService *)getValidateCodeService{
    if (_getValidateCodeService == nil) {
        _getValidateCodeService = [[KSLoginService alloc] init];
        WEAKSELF
        _getValidateCodeService.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            [WeAppToast toast:@"验证码已发送"];
        };
        
        _getValidateCodeService.serviceDidFailLoadBlock = ^(WeAppBasicService* service , NSError* error){
            NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
            [WeAppToast toast:errorInfo];
        };
    }
    return _getValidateCodeService;
}

-(KSRegisterViewCtl *)registerViewCtl{
    if (_registerViewCtl == nil) {
        _registerViewCtl = [[KSRegisterViewCtl alloc] initWithFrame:self.bounds];
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
            if([MWUtils isValidPassword:registerViewCtl.text_psw.text])
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
        
        _registerViewCtl.getValidateColdBlock = ^(KSRegisterViewCtl* registerViewCtl){
            STRONGSELF
            if(registerViewCtl.text_phoneNum.text.length == 0)
            {
                [WeAppToast toast:@"请输入正确的手机号"];
                return NO;
            }
            [strongSelf.getValidateCodeService sendValidateCodeWithAccountName:registerViewCtl.text_phoneNum.text];
            return YES;
        };
    }
    return _registerViewCtl;
}

@end
