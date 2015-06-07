//
//  KSLoginView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSLoginView.h"

@interface KSLoginView()

@property (nonatomic, strong) KSAdapterService  *service;

@end

@implementation KSLoginView

-(void)setupView{
    [super setupView];
    [self addSubview:self.loginViewCtl.logo_imgView];
    [self addSubview:self.loginViewCtl.text_phoneNum];
    [self addSubview:self.loginViewCtl.text_psw];
    [self addSubview:self.loginViewCtl.btn_forgetPwd];
    [self addSubview:self.loginViewCtl.btn_login];
}

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        [_service setItemClass:[NSDictionary class]];
        _service.jsonTopKey = @"data";
        WEAKSELF
        _service.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            // 存储逻辑需要封装优化
            NSDictionary *dic_userInfo = [NSDictionary dictionaryWithDictionary:(NSDictionary*)service.requestModel.item];
            NSLog(@"%@",dic_userInfo);
            [[KSUserInfoModel sharedConstant]updateUserInfo:dic_userInfo];
            [[NSFileManager defaultManager] createDirectoryAtPath:[LOGIN_FLAG filePathOfCaches] withIntermediateDirectories:YES attributes:nil error:nil];
            
            [strongSelf.viewController dismissViewControllerAnimated:YES completion:nil];
            if (strongSelf.loginActionBlock) {
                strongSelf.loginActionBlock(YES);
            }
        };
        
        _service.serviceDidFailLoadBlock = ^(WeAppBasicService* service , NSError* error){
            NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
            [WeAppToast toast:errorInfo];
        };
    }
    return _service;
}

-(KSLoginViewCtl *)loginViewCtl{
    if (_loginViewCtl == nil) {
        _loginViewCtl = [[KSLoginViewCtl alloc] initWithFrame:self.bounds];
        WEAKSELF
        _loginViewCtl.loginBlock = ^(KSLoginViewCtl* loginViewCtl){
            STRONGSELF
            if(loginViewCtl.text_phoneNum.text.length == 0)
            {
                [WeAppToast toast:@"请输入正确的手机号"];
                return;
            }else if(loginViewCtl.text_psw.text.length == 0)
            {
                [WeAppToast toast:@"请输入密码"];
                return;
            }
            
            [strongSelf.service loadItemWithAPIName:strongSelf.loginApiName params:@{strongSelf.loginUserIdKey?:@"phone":loginViewCtl.text_phoneNum.text, strongSelf.loginSecurityKey?:@"pwd":loginViewCtl.text_psw.text} version:nil];
        };
        
        _loginViewCtl.cancelLoginBlock = ^(KSLoginViewCtl* loginViewCtl){
            STRONGSELF
            [strongSelf.viewController dismissViewControllerAnimated:YES completion:nil];
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
    return _loginViewCtl;
}

@end
