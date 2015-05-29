//
//  ManWuLoginViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/15.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSManWuViewController.h"

@interface ManWuLoginViewController : KSManWuViewController<UITextFieldDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) UIImageView *logo_imgView;
@property (nonatomic, strong) MWInsetsTextField *text_phoneNum;
@property (nonatomic, strong) MWInsetsTextField *text_psw;
@property (nonatomic, strong) UIButton *btn_login;
@property (nonatomic, strong) UIButton *btn_register;
@property (nonatomic, strong) UIButton *btn_cancel;
@property (nonatomic, strong) UIButton *btn_forgetPwd;
@property (nonatomic, strong) UIView *navgationView;

@property (nonatomic, strong) KSAdapterService *service;


@end
