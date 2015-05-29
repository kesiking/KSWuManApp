//
//  ManWuChangePwdViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/5/19.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManWuChangePwdViewController : UIViewController<WeAppBasicServiceDelegate,UITextFieldDelegate>

@property (nonatomic, strong) MWInsetsTextField *text_oldPwd;   //原始密码
@property (nonatomic, strong) MWInsetsTextField *text_newPwd;   //新密码
@property (nonatomic, strong) MWInsetsTextField *text_renewPwd;
@property (nonatomic, strong) UIButton *btn_commit;

@property (nonatomic, strong) KSAdapterService *service;

@end
