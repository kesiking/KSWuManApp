//
//  KSRegisterViewCtl.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeAppBasicFieldView.h"

@class KSRegisterViewCtl;

typedef void (^doRegisterBlock)         (KSRegisterViewCtl* registerViewCtl);

typedef BOOL (^doGetValidateColdBlock)  (KSRegisterViewCtl* registerViewCtl);

typedef void (^doCancelRegisterBlock)   (KSRegisterViewCtl* registerViewCtl);

@interface KSRegisterViewCtl : NSObject

@property (nonatomic, strong) UIImageView               *logo_imgView;
@property (nonatomic, strong) WeAppBasicFieldView       *text_phoneNum;
@property (nonatomic, strong) WeAppBasicFieldView       *text_smsCode;
@property (nonatomic, strong) WeAppBasicFieldView       *text_psw;
@property (nonatomic, strong) WeAppBasicFieldView       *text_inviteCode;
@property (nonatomic, strong) WeAppBasicFieldView       *text_userName;
@property (nonatomic, strong) UIView                    *smsCodeView;
@property (nonatomic, strong) UIButton                  *btn_smsCode;
@property (nonatomic, strong) UIButton                  *btn_register;
@property (nonatomic, strong) UIButton                  *btn_cancel;

@property (nonatomic, assign) NSUInteger                smsCodeSeconds;

@property (nonatomic, strong) doRegisterBlock           registerBlock;
@property (nonatomic, strong) doGetValidateColdBlock    getValidateColdBlock;
@property (nonatomic, strong) doCancelRegisterBlock     cancelRegisterBlock;

-(instancetype)initWithFrame:(CGRect)frame;

@end
