//
//  KSResetView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/10.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSResetView.h"
#import "MWUtils.h"
#import "KSLoginComponentItem.h"
#import "KSLoginUrlPath.h"

@implementation KSResetView

-(void)setupView{
    [super setupView];
    [self initLoginViewCtl];
    [self reloadData];
}

-(void)initLoginViewCtl{
    self.resetViewCtl.text_phoneNum.hidden = NO;
    self.resetViewCtl.smsCodeView.hidden = NO;
    self.resetViewCtl.btn_nextStep.hidden = NO;

    [self addSubview:self.resetViewCtl];
}

-(void)reloadData{
    self.resetViewCtl.text_phoneNum.text = [[KSLoginComponentItem sharedInstance] getAccountName];

}

-(void)layoutSubviews{
    [super layoutSubviews];
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

-(void)setResetViewCtl:(KSResetViewCtl *)resetViewCtl{
    if (_resetViewCtl != resetViewCtl) {
        _resetViewCtl = nil;
        _resetViewCtl = resetViewCtl;
        [self setupResetViewCtl];
    }
}

-(KSResetViewCtl *)getResetViewCtl{
    if (_resetViewCtl == nil) {
        _resetViewCtl = [[KSResetViewCtl alloc] initWithFrame:self.bounds];
        [self setupResetViewCtl];
    }
    return _resetViewCtl;
}

-(void)setupResetViewCtl{
    WEAKSELF
    _resetViewCtl.getValidateColdBlock = ^(KSValidateCodeViewCtl* resetViewCtl){
        STRONGSELF
        if(![MWUtils isValidMobile:((KSResetViewCtl*)resetViewCtl).text_phoneNum.text])
        {
            [WeAppToast toast:@"请输入正确的手机号"];
            return NO;
        }
        [strongSelf.validateCodeService sendValidateCodeWithAccountName:((KSResetViewCtl*)resetViewCtl).text_phoneNum.text];
        return YES;
    };
    
    _resetViewCtl.nextStepBlock = ^(KSResetViewCtl* resetViewCtl){
        STRONGSELF
        //判断逻辑待完善
        if(![MWUtils isValidMobile:resetViewCtl.text_phoneNum.text])
        {
            [WeAppToast toast:@"请输入正确的手机号"];
            return;
        }else if(resetViewCtl.text_smsCode.text == nil
                 || resetViewCtl.text_smsCode.text.length == 0)
        {
            [WeAppToast toast:@"请输入验证码"];
            return;
        }
        NSString* smsCode = resetViewCtl.text_smsCode.text;
        NSString* phoneNum = resetViewCtl.text_phoneNum.text;
        NSDictionary* params= @{@"smsCode":smsCode,@"phoneNum":phoneNum};
        TBOpenURLFromTargetWithNativeParams(internalURL(kDoneResetPwdPage), strongSelf, nil,params);
    };
}

@end
