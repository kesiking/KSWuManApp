//
//  ManWuRegisterViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuRegisterViewController : UIViewController<UITextFieldDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) UIImageView *logo_imgView;
@property (nonatomic, strong) MWInsetsTextField *text_phoneNum;
@property (nonatomic, strong) MWInsetsTextField *text_smsCode;
@property (nonatomic, strong) MWInsetsTextField *text_psw;
@property (nonatomic, strong) MWInsetsTextField *text_inviteCode;
@property (nonatomic, strong) MWInsetsTextField *text_userName;
@property (nonatomic, strong) UIView *smsCodeView;
@property (nonatomic, strong) UIButton *btn_smsCode;
@property (nonatomic, strong) UIButton *btn_register;
@property (nonatomic, strong) UIButton *btn_cancel;
@property (nonatomic, strong) UIView *navgationView;

@property (nonatomic, strong) KSAdapterService *service;

@end
