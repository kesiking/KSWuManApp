//
//  KSValidateCodeViewCtl.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/9.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSValidateCodeViewCtl.h"
#import "KSLoginMaroc.h"

@implementation KSValidateCodeViewCtl

-(WeAppBasicFieldView *)text_smsCode{
    if (!_text_smsCode) {
        _text_smsCode = [WeAppBasicFieldView getCommonFieldView];
        _text_smsCode.frame = CGRectMake(0, 0, (validate_width)/2 + 20, text_height);
        _text_smsCode.textView.placeholder = @"验证码";
        [_text_smsCode setBackgroundColor:[UIColor clearColor]];
    }
    return _text_smsCode;
}

-(UIButton *)btn_smsCode{
    if (!_btn_smsCode) {
        _btn_smsCode = [[UIButton alloc]initWithFrame:CGRectMake((validate_width)/2 + 20, 0, (validate_width)/2 - 20, text_height)];
        [_btn_smsCode setTitle:@"获取验证码"forState:UIControlStateNormal];
        [_btn_smsCode setBackgroundColor:[UIColor colorWithRed:0xb9/255.0 green:0xb9/255.0 blue:0xb9/255.0 alpha:1.0]];
        [_btn_smsCode addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];        [_btn_smsCode addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_smsCode;
}

- (UIView *)smsCodeView
{
    if(!_smsCodeView)
    {
        _smsCodeView = [[UIView alloc]initWithFrame:CGRectMake(kSpaceX, 0, validate_width, text_height)];
        _smsCodeView.backgroundColor = [UIColor clearColor];
        [_smsCodeView addSubview:self.text_smsCode];
        [_smsCodeView addSubview:self.btn_smsCode];
        [self addSubview:_smsCodeView];
    }
    
    return _smsCodeView;
}

- (void)getValidateCode
{
    //判断逻辑待完善
    BOOL canGetValidateCode = NO;
    
    if (self.getValidateColdBlock) {
        canGetValidateCode = self.getValidateColdBlock(self);
    }
    
    if (!canGetValidateCode) {
        return;
    }
    
    [self showSecondTimeout:self.smsCodeSeconds > 0 ?:90 target:self timerOutAction:@selector(updateUIWhenSecondTimeout:)];
}

-(void)dealloc{
    self.getValidateColdBlock = nil;
}

#pragma mark - helper functions
- (void)updateUIWhenSecondTimeout:(NSDictionary*)userinfo
{
    BOOL bEnd = [[userinfo objectForKey:@"timerend"] boolValue];
    if (bEnd)
    {
        _btn_smsCode.enabled = YES;
        //设置界面的按钮显示
        [_btn_smsCode setBackgroundColor:[UIColor colorWithRed:0xb9/255.0 green:0xb9/255.0 blue:0xb9/255.0 alpha:1.0]];
        [_btn_smsCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        NSUInteger remainTime = [[userinfo objectForKey:@"remaintime"] unsignedIntegerValue];
        NSString *strTime = [NSString stringWithFormat:@"%lus后重新获取",(unsigned long)remainTime];
        
        _btn_smsCode.enabled = NO;
        //设置界面的按钮显示
        [_btn_smsCode setBackgroundColor:[UIColor redColor]];
        [_btn_smsCode setTitle:strTime forState:UIControlStateDisabled];
    }
}

- (void)showSecondTimeout:(NSUInteger)time target:(id)target timerOutAction:(SEL)action
{
    __block NSUInteger timeout= time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //没秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            //            dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithBool:YES] forKey:@"timerend"];
                [target performSelector:action withObject:userInfo];
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithBool:NO] forKey:@"timerend"];
                [userInfo setObject:[NSNumber numberWithUnsignedInteger:timeout] forKey:@"remaintime"];
                [target performSelector:action withObject:userInfo];
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

@end
