//
//  KSResetViewCtl.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSResetViewCtl.h"

#define reset_width     (self.frame.size.width - kSpaceX * 2)

@interface KSResetViewCtl()<UITextFieldDelegate>

@end

@implementation KSResetViewCtl

-(id)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
}

-(WeAppBasicFieldView *)text_oldPwd{
    if(!_text_oldPwd)
    {
        _text_oldPwd = [WeAppBasicFieldView getSecurityFieldView];
        _text_oldPwd.textView.placeholder = @"原始密码";
        [self addSubview:_text_oldPwd];
    }
    return _text_oldPwd;
}

- (WeAppBasicFieldView *)text_newPwd
{
    if(!_text_newPwd)
    {
        _text_newPwd = [WeAppBasicFieldView getSecurityFieldView];
        _text_newPwd.textView.placeholder = @"新密码";
        [self addSubview:_text_newPwd];
    }
    return _text_newPwd;
}

- (WeAppBasicFieldView *)text_renewPwd
{
    if(!_text_renewPwd)
    {
        _text_renewPwd = [WeAppBasicFieldView getSecurityFieldView];;
        _text_renewPwd.textView.placeholder = @"确认新密码";
        [self addSubview:_text_renewPwd];
    }
    return _text_renewPwd;
}

- (UIButton *)btn_done
{
    if(!_btn_done)
    {
        _btn_done = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_renewPwd.frame) + 30, reset_width, text_height)];
        _btn_done.layer.cornerRadius = 5;
        _btn_done.layer.masksToBounds = YES;
        [_btn_done setTitle:@"完成" forState:UIControlStateNormal];
        [_btn_done.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_done.titleLabel.textColor = [UIColor whiteColor];
        [_btn_done setBackgroundColor:[UIColor colorWithRed:0xdc/255.0 green:0x78/255.0 blue:0x68/255.0 alpha:1.0]];
        [_btn_done addTarget:self action:@selector(resetPwdDone) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_done];
    }
    
    return _btn_done;
}

- (WeAppBasicFieldView *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [WeAppBasicFieldView getCommonFieldView];
        _text_phoneNum.textView.placeholder = @"手机号码";
        [self addSubview:_text_phoneNum];
    }
    return _text_phoneNum;
}

- (UIButton *)btn_nextStep
{
    if(!_btn_nextStep)
    {
        _btn_nextStep = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(self.smsCodeView.frame) + 30, reset_width, text_height)];
        _btn_nextStep.layer.cornerRadius = 5;
        _btn_nextStep.layer.masksToBounds = YES;
        [_btn_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        [_btn_nextStep.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_nextStep.titleLabel.textColor = [UIColor whiteColor];
        [_btn_nextStep setBackgroundColor:[UIColor colorWithRed:0xdc/255.0 green:0x78/255.0 blue:0x68/255.0 alpha:1.0]];
        [_btn_nextStep addTarget:self action:@selector(doNextStep) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_nextStep];
    }
    
    return _btn_nextStep;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _text_oldPwd.frame = CGRectMake(kSpaceX, 30, reset_width, text_height);
    if (_text_oldPwd) {
        _text_newPwd.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_text_oldPwd.frame) + text_border, reset_width, text_height);
    }else{
        _text_newPwd.frame = CGRectMake(kSpaceX, 30, reset_width, text_height);
    }
    _text_renewPwd.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_text_newPwd.frame) + text_border, reset_width, text_height);
    _btn_done.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_text_renewPwd.frame) + 30, reset_width, text_height);
    
    _text_phoneNum.frame = CGRectMake(kSpaceX, 30, reset_width, text_height);
    _smsCodeView.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_text_phoneNum.frame) + text_border, reset_width, text_height);
    _btn_nextStep.frame = CGRectMake(kSpaceX, CGRectGetMaxY(_smsCodeView.frame) + 30, reset_width, text_height);
}

- (void)doNextStep
{
    //判断逻辑待完善
    if (self.nextStepBlock) {
        self.nextStepBlock(self);
    }
}

- (void)resetPwdDone
{
    if (self.resetPwdDoneBlock) {
        self.resetPwdDoneBlock(self);
    }
}

-(void)dealloc{
    self.nextStepBlock = nil;
    self.resetPwdDoneBlock = nil;
}

@end
