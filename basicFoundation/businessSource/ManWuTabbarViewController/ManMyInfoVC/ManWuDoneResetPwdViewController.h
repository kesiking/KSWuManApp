//
//  ManWuDoneResetPwdViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/6/2.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuDoneResetPwdViewController : UIViewController<UITextFieldDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) MWInsetsTextField *text_newPwd;
@property (nonatomic, strong) MWInsetsTextField *text_renewPwd;
@property (nonatomic, strong) NSString *smsCode;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) UIButton *btn_done;

@property (nonatomic, strong) KSAdapterService *service;


@end
