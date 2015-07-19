//
//  ManWuUserNameViewController.h
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UserInfoConfigStyle) {
    UserInfoConfigUserNameStyle,
    UserInfoConfigSexStyle,
    UserInfoConfigEmailStyle
};

@interface ManWuUserNameViewController : UIViewController<WeAppBasicServiceDelegate,UITextFieldDelegate>

@property (nonatomic, strong) MWInsetsTextField *text_userInfo;
@property (nonatomic, strong) UIButton *btn_commit;
@property (nonatomic, assign) UserInfoConfigStyle configStyle;

@property (nonatomic, strong) KSAdapterService *service;

@end
