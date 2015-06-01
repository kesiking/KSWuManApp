//
//  ManWuResetPwdViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/16.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuResetPwdViewController : UIViewController<UITextFieldDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) MWInsetsTextField *text_phoneNum;
@property (nonatomic, strong) MWInsetsTextField *text_smsCode;
@property (nonatomic, strong) MWInsetsTextField *text_newPwd;
@property (nonatomic, strong) UIView *smsCodeView;
@property (nonatomic, strong) UIButton *btn_smsCode;
@property (nonatomic, strong) UIButton *btn_nextStep;
@property (nonatomic, strong) UIView *navgationView;
@property (nonatomic, strong) UIButton *btn_cancel;


@property (nonatomic, strong) KSAdapterService *service;

@end
