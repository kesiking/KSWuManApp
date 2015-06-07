//
//  ManWuResetPwdViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/16.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuResetPwdViewController.h"

@interface ManWuResetPwdViewController ()

@end

@implementation ManWuResetPwdViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        
    }
    return self;
}


-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        //[_service setItemClass:[KSModelDemo class]];
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];

    self.title = @"找回密码";
    [self.view addSubview:self.text_phoneNum];
    [self.view addSubview:self.smsCodeView];
    [self.view addSubview:self.btn_nextStep];
}

- (MWInsetsTextField *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 30, SELFWIDTH, 40)];
        _text_phoneNum.placeholder = @"手机号码";
        [_text_phoneNum setFont:[UIFont systemFontOfSize:16]];
        _text_phoneNum.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_phoneNum.keyboardType = UIKeyboardTypeNumberPad;
        _text_phoneNum.clearButtonMode = UITextFieldViewModeAlways;
        _text_phoneNum.secureTextEntry = NO;
        _text_phoneNum.delegate = self;
        [_text_phoneNum setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_phoneNum;
}

- (UIView *)smsCodeView
{
    if(!_smsCodeView)
    {
        _smsCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_phoneNum.frame) + 1, SELFWIDTH, 40)];
        _smsCodeView.backgroundColor = [UIColor clearColor];
        _text_smsCode = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 0, (SELFWIDTH)/2 + 20, 40)];
        _text_smsCode.placeholder = @"验证码";
        [_text_smsCode setFont:[UIFont systemFontOfSize:16]];
        //        _text_smsCode.layer.borderWidth = 1.0;
        _text_smsCode.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_smsCode.keyboardType = UIKeyboardTypeNumberPad;
        _text_smsCode.clearButtonMode = UITextFieldViewModeAlways;
        _text_smsCode.secureTextEntry = YES;
        [_text_smsCode setBackgroundColor:[UIColor whiteColor]];
        
        _btn_smsCode = [[UIButton alloc]initWithFrame:CGRectMake((SELFWIDTH)/2 + 20, 0, (SELFWIDTH)/2 - 20, 40)];
        [_btn_smsCode setTitle:@"获取验证码"forState:UIControlStateNormal];
        [_btn_smsCode setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle colorWithHexString:@"#b9b9b9"]] forState:UIControlStateNormal];
        [_btn_smsCode addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];        [_btn_smsCode addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];
        
        [_smsCodeView addSubview:_text_smsCode];
        
        [_smsCodeView addSubview:_btn_smsCode];
        
    }
    
    return _smsCodeView;
}

- (UIButton *)btn_nextStep
{
    if(!_btn_nextStep)
    {
        _btn_nextStep = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_smsCodeView.frame) + 30, WIDTH, 40)];
        [_btn_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        [_btn_nextStep.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_nextStep.titleLabel.textColor = [UIColor whiteColor];
        [_btn_nextStep setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_nextStep addTarget:self action:@selector(doNextStep) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_nextStep;
}

- (void)getValidateCode
{
    //判断逻辑待完善
    if(_text_phoneNum.text.length == 0)
    {
        [WeAppToast toast:@"请输入正确的手机号"];
        return;
    }
    [self.service loadNumberValueWithAPIName:@"user/sendValidateCode.do" params:@{@"phoneNum":_text_phoneNum.text} version:nil];
    
    [self showSecondTimeout:90 target:self timerOutAction:@selector(updateUIWhenSecondTimeout:)];
    
}

- (void)doNextStep
{
    //判断逻辑待完善
    if(_text_phoneNum.text.length == 0)
    {
        [WeAppToast toast:@"请输入正确的手机号"];
        return;
    }else if(_text_smsCode.text.length == 0)
    {
        [WeAppToast toast:@"请输入验证码"];
        return;
    }

}

#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
    }
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
        NSLog(@"%@",service.item.componentDict);
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
    }
}

#pragma mark - helper functions
- (void)updateUIWhenSecondTimeout:(NSDictionary*)userinfo
{
    BOOL bEnd = [[userinfo objectForKey:@"timerend"] boolValue];
    if (bEnd)
    {
        _btn_smsCode.enabled = YES;
        //设置界面的按钮显示
        [_btn_smsCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        NSUInteger remainTime = [[userinfo objectForKey:@"remaintime"] unsignedIntegerValue];
        NSString *strTime = [NSString stringWithFormat:@"%lus后重新获取",(unsigned long)remainTime];
        
        _btn_smsCode.enabled = NO;
        //设置界面的按钮显示
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
