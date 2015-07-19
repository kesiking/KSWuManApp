//
//  ManWuRegisterViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/14.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuRegisterViewController.h"

@interface ManWuRegisterViewController ()
{
    BOOL isRegister;
    KSRegisterSuccessView *registerSucView;
    BOOL isKeyShow;//是否有键盘
}

@end

@implementation ManWuRegisterViewController

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        [_service setItemClass:[WeAppComponentBaseItem class]];
        _service.jsonTopKey = @"data";
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    
    self.title = @"手机注册";
    isRegister = NO;
    [self.view addSubview:self.logo_imgView];
    [self.view addSubview:self.text_phoneNum];
    [self.view addSubview:self.text_psw];
    [self.view addSubview:self.smsCodeView];
    [self.view addSubview:self.text_inviteCode];
    [self.view addSubview:self.btn_register];
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //注册键盘显示通知
    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [center addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIImageView *)logo_imgView
{
    if(!_logo_imgView)
    {
        _logo_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SELFWIDTH/2 - 30, 30, 60, 60)];
        _logo_imgView.backgroundColor = [UIColor redColor];
    }
    return _logo_imgView;
}

- (MWInsetsTextField *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logo_imgView.frame) + 30, SELFWIDTH, TEXTFILEDHEIGHT)];
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

- (MWInsetsTextField *)text_psw
{
    if(!_text_psw)
    {
        _text_psw = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_phoneNum.frame) + 1, SELFWIDTH, TEXTFILEDHEIGHT)];
        _text_psw.placeholder = @"密码";
        [_text_psw setFont:[UIFont systemFontOfSize:16]];
        _text_psw.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_psw.keyboardType = UIKeyboardTypeNamePhonePad;
        _text_psw.clearButtonMode = UITextFieldViewModeAlways;
        _text_psw.secureTextEntry = YES;
        _text_psw.delegate = self;
        [_text_psw setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_psw;
}

- (UIView *)smsCodeView
{
    if(!_smsCodeView)
    {
        _smsCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_psw.frame) + 1, SELFWIDTH, TEXTFILEDHEIGHT)];
        _smsCodeView.backgroundColor = [UIColor clearColor];
        _text_smsCode = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 0, (SELFWIDTH)/2 + 20, TEXTFILEDHEIGHT)];
        _text_smsCode.placeholder = @"验证码";
        [_text_smsCode setFont:[UIFont systemFontOfSize:16]];
        //        _text_smsCode.layer.borderWidth = 1.0;
        _text_smsCode.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_smsCode.keyboardType = UIKeyboardTypeNumberPad;
        _text_smsCode.clearButtonMode = UITextFieldViewModeAlways;
        _text_smsCode.secureTextEntry = YES;
        [_text_smsCode setBackgroundColor:[UIColor whiteColor]];
        
        _btn_smsCode = [[UIButton alloc]initWithFrame:CGRectMake((SELFWIDTH)/2 + 20, 0, (SELFWIDTH)/2 - 20, TEXTFILEDHEIGHT)];
        [_btn_smsCode setTitle:@"获取验证码"forState:UIControlStateNormal];
        _btn_smsCode.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btn_smsCode setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle colorWithHexString:@"#b9b9b9"]] forState:UIControlStateNormal];
        [_btn_smsCode addTarget:self action:@selector(getValidateCode) forControlEvents:UIControlEventTouchUpInside];
        
        [_smsCodeView addSubview:_text_smsCode];
        
        [_smsCodeView addSubview:_btn_smsCode];
        
    }
    
    return _smsCodeView;
}

- (MWInsetsTextField *)text_inviteCode
{
    if(!_text_inviteCode)
    {
        _text_inviteCode = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_smsCodeView.frame) + 1, SELFWIDTH, TEXTFILEDHEIGHT)];
        _text_inviteCode.placeholder = @"邀请码";
        [_text_inviteCode setFont:[UIFont systemFontOfSize:16]];
        _text_inviteCode.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_inviteCode.keyboardType = UIKeyboardTypeNamePhonePad;
        _text_inviteCode.clearButtonMode = UITextFieldViewModeAlways;
        _text_inviteCode.secureTextEntry = NO;
        _text_inviteCode.delegate = self;
        [_text_inviteCode setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_inviteCode;
}

- (MWInsetsTextField *)text_userName
{
    if(!_text_userName)
    {
        _text_userName = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_inviteCode.frame) + 15, WIDTH, TEXTFILEDHEIGHT)];
        _text_userName.placeholder = @"用户名";
        [_text_userName setFont:[UIFont systemFontOfSize:16]];
        _text_userName.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _text_userName.keyboardType = UIKeyboardTypeNumberPad;
        _text_userName.clearButtonMode = UITextFieldViewModeAlways;
        _text_userName.secureTextEntry = NO;
        _text_userName.delegate = self;
        [_text_userName setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_userName;
}

- (UIButton *)btn_register
{
    if(!_btn_register)
    {
        _btn_register = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_inviteCode.frame) + 30, WIDTH, TEXTFILEDHEIGHT)];
        [_btn_register setTitle:@"注册" forState:UIControlStateNormal];
        [_btn_register.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_register.titleLabel.textColor = [UIColor whiteColor];
        [_btn_register setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];

        [_btn_register addTarget:self action:@selector(registerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_register;
}

#pragma mark 监听View点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}

#pragma mark 键盘显示时调用
- (void)keyBoardWillShow:(NSNotification *)notification
{
    if(isKeyShow)
    {
        return;
    }
    isKeyShow=YES;
    //    //获取LoginArea的视图
    //    UIView *LoginArea=[self.view viewWithTag:VIEW_TAG];
    //    //获取LoginArea的Rect
    //    CGRect loginAreaRect=LoginArea.frame;
    //键盘Rect
    CGRect keyBoardRect=[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //偏移量
    CGFloat distance=keyBoardRect.origin.y-CGRectGetMaxY(_text_inviteCode.frame) - 64;
    if (distance<0) {
        [self animationWithUserInfo:notification.userInfo bloack:^{
            if (self.view.frame.size.height == 480) {
                self.view.transform=CGAffineTransformTranslate(self.view.transform, 0, distance - 20);
                
            }
            else{
                //                self.ZYlabel.transform=CGAffineTransformTranslate(self.ZYlabel.transform, 0, distance);
                self.view.transform=CGAffineTransformTranslate(self.view.transform, 0, distance);
            }
            //            self.ZYlabel.transform = CGAffineTransformTranslate(self.ZYlabel.transform, 0, distance);
        }];
    }
}
#pragma mark 键盘隐藏时调用
- (void)keyBoardWillHidden:(NSNotification *)notification
{
    isKeyShow=NO;
    [self animationWithUserInfo:notification.userInfo bloack:^{
        self.view.transform=CGAffineTransformIdentity;
        //        self.ZYlabel.transform = CGAffineTransformIdentity;
    }];
    
}
#pragma mark 键盘动画
- (void)animationWithUserInfo:(NSDictionary *)userInfo bloack:(void (^)(void))block
{
    // 取出键盘弹出的时间
    CGFloat duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue];
    // 取出键盘弹出动画曲线
    NSInteger curve=[userInfo[UIKeyboardAnimationCurveUserInfoKey]integerValue];
    //开始动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    //调用bock
    block();
    [UIView commitAnimations];
}

- (void)getValidateCode
{
    if(_text_phoneNum.text.length == 0)
    {
        [WeAppToast toast:@"请输入手机号"];
        return;
    }
    if(![KSUtils isValidMobile:_text_phoneNum.text])
    {
        [WeAppToast toast:@"请输入正确的手机号"];
        return;
    }
    [self.service loadNumberValueWithAPIName:@"user/sendValidateCode.do" params:@{@"phoneNum":_text_phoneNum.text} version:nil];
    
    [self showSecondTimeout:90 target:self timerOutAction:@selector(updateUIWhenSecondTimeout:)];
    
}

- (void)registerButtonTapped
{
    [self.view endEditing:NO];
    //判断规则后续完善
    
    if(_text_phoneNum.text.length == 0)
    {
        [WeAppToast toast:@"请输入手机号"];
        return;
    }else if(![KSUtils isValidMobile:_text_phoneNum.text])
    {
        [WeAppToast toast:@"请输入正确的手机号"];
        return;
    }else if(_text_smsCode.text.length == 0)
    {
        [WeAppToast toast:@"请输入验证码"];
        return;
    }
    if(_text_psw.text.length == 0)
    {
        [WeAppToast toast:@"请输入密码"];
        return;
    }
    
#ifdef LOGIN_NEED_ENCRYPT
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"aliPayfile" ofType:@"plist"];
    NSDictionary* aliPayFile = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if (aliPayFile == nil) {
        aliPayFile = [[NSDictionary alloc] init];
    }
    NSString* passwordKey = [aliPayFile objectForKey:@"passwordKey1"];
    NSString *signedPwd = [RSAEncrypt encryptString:_text_psw.text publicKey:passwordKey];
    NSString* method = @"GET";

#ifdef LOGIN_USE_POST_ENCRYPT
    method = @"POST";
#endif
    [self.service loadItemWithAPIName:@"user/register.do" params:@{@"phoneNum":_text_phoneNum.text, @"pwd":[signedPwd tbUrlEncoded]?:@"", @"validateCode":_text_smsCode.text, @"code":_text_inviteCode.text?:@"",@"userName":_text_userName.text?:@"",@"__unNeedEncode__":@1,@"__METHOD__":method} version:nil];
#else
    [self.service loadItemWithAPIName:@"user/login.do" params:@{@"phoneNum":_text_phoneNum.text, @"pwd":_text_psw.text, @"validateCode":_text_smsCode.text, @"code":_text_inviteCode.text?:@"", @"userName":_text_userName.text?:@""} version:nil];
#endif

    isRegister = YES;
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
        if(isRegister)
        {
            //[WeAppToast toast:@"注册成功"];
            NSDictionary *dic_userInfo = [NSDictionary dictionaryWithDictionary:service.requestModel.item.componentDict];
            NSInteger redPacketPrice = [[dic_userInfo objectForKey:@"voucher"]integerValue];
            
            if(redPacketPrice == 0)
            {
                [WeAppToast toast:@"恭喜您注册成功"];
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            registerSucView = [[KSRegisterSuccessView alloc]initWithFrame:self.view.frame RedPackerPrice:redPacketPrice];
            registerSucView.delegate = self;
            [self.view.window addSubview:registerSucView];
            
        }else
        {
            [WeAppToast toast:@"验证码已发送"];
        }

    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
        if(isRegister)
        {
            isRegister = NO;
        }
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
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

#pragma mark - 注册红包关闭按钮回调KSRegisterSuccessViewDelegate

- (void)didClickCloseButton
{
    [registerSucView removeFromSuperview];
    registerSucView = nil;
    [self.navigationController popViewControllerAnimated:YES];
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
