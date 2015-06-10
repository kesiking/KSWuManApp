//
//  KSDoneResetView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/10.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSDoneResetView.h"
#import "MWUtils.h"

@implementation KSDoneResetView

-(void)setupView{
    [super setupView];
    [self initResetViewCtl];
    [self reloadData];
}

-(void)initResetViewCtl{
    self.resetViewCtl.text_renewPwd.hidden = NO;
    self.resetViewCtl.text_newPwd.hidden = NO;
    self.resetViewCtl.btn_done.hidden = NO;
    
    [self addSubview:self.resetViewCtl];
}

-(void)reloadData{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
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
        [WeAppToast toast:@"重置密码成功"];
        if (strongSelf.resetPasswordAction) {
            strongSelf.resetPasswordAction(YES);
        }
    };
    
    _service.serviceDidFailLoadBlock = ^(WeAppBasicService* service , NSError* error){
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
    
    _resetViewCtl.resetPwdDoneBlock = ^(KSResetViewCtl* resetViewCtl){
        STRONGSELF
        //判断逻辑待完善
        if(![MWUtils isValidMobile:strongSelf.phoneNum])
        {
            [WeAppToast toast:@"手机号有误"];
            return;
        }
        if(strongSelf.smsCode == nil || strongSelf.smsCode.length == 0)
        {
            [WeAppToast toast:@"验证码有误"];
            return;
        }
        if (![MWUtils isValidPassword:resetViewCtl.text_newPwd.text]) {
            [WeAppToast toast:@"请输入正确的新密码"];
            return;
        }
        if (![MWUtils isValidPassword:resetViewCtl.text_renewPwd.text]) {
            [WeAppToast toast:@"请输入正确的确认密码"];
            return;
        }
        if(![resetViewCtl.text_renewPwd.text isEqualToString:resetViewCtl.text_newPwd.text]){
            [WeAppToast toast:@"确认密码与新密码不相符"];
            return;
        }

        [strongSelf.service resetPasswordWithAccountName:strongSelf.phoneNum validateCode:strongSelf.smsCode newPassword:resetViewCtl.text_renewPwd.text];
    };
}

@end
