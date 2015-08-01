//
//  ManWuDoneResetPwdViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/2.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDoneResetPwdViewController.h"

@interface ManWuDoneResetPwdViewController ()

@end

@implementation ManWuDoneResetPwdViewController

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
    [self.view addSubview:self.text_newPwd];
    [self.view addSubview:self.text_renewPwd];
    [self.view addSubview:self.btn_done];
}

- (MWInsetsTextField *)text_newPwd
{
    if(!_text_newPwd)
    {
        _text_newPwd = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 30, SELFWIDTH, TEXTFILEDHEIGHT)];
        _text_newPwd.placeholder = @"新密码";
        [_text_newPwd setFont:[UIFont systemFontOfSize:16]];
        _text_newPwd.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_newPwd.keyboardType = UIKeyboardTypeNumberPad;
        _text_newPwd.clearButtonMode = UITextFieldViewModeAlways;
        _text_newPwd.secureTextEntry = YES;
        _text_newPwd.delegate = self;
        [_text_newPwd setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_newPwd;
}

- (MWInsetsTextField *)text_renewPwd
{
    if(!_text_renewPwd)
    {
        _text_renewPwd = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_newPwd.frame) + 1, SELFWIDTH, TEXTFILEDHEIGHT)];
        _text_renewPwd.placeholder = @"确认新密码";
        [_text_renewPwd setFont:[UIFont systemFontOfSize:16]];
        _text_renewPwd.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_renewPwd.keyboardType = UIKeyboardTypeNumberPad;
        _text_renewPwd.clearButtonMode = UITextFieldViewModeAlways;
        _text_renewPwd.secureTextEntry = YES;
        _text_renewPwd.delegate = self;
        [_text_renewPwd setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_renewPwd;
}

- (UIButton *)btn_done
{
    if(!_btn_done)
    {
        _btn_done = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_renewPwd.frame) + 30, WIDTH, 40)];
        [_btn_done setTitle:@"下一步" forState:UIControlStateNormal];
        [_btn_done.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_done.titleLabel.textColor = [UIColor whiteColor];
        [_btn_done setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_done addTarget:self action:@selector(resetPwdDone) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_done;
}

#pragma mark 监听View点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}

- (void)resetPwdDone
{
    //判断逻辑待完善
    if(_text_newPwd.text.length == 0)
    {
        [WeAppToast toast:@"请输入新密码"];
        return;
    }else if (_text_renewPwd.text.length == 0)
    {
        [WeAppToast toast:@"请确认新密码"];
        return;
        
    }else if (![_text_newPwd.text isEqualToString:_text_renewPwd.text])
    {
        [WeAppToast toast:@"新密码输入不一致"];
        return;
    }
    
#ifdef LOGIN_NEED_ENCRYPT
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"aliPayfile" ofType:@"plist"];
    NSDictionary* aliPayFile = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if (aliPayFile == nil) {
        aliPayFile = [[NSDictionary alloc] init];
    }
    NSString* passwordKey = [aliPayFile objectForKey:@"passwordKey1"];
    
    //    NSString *signedPwd = [KSUtils encryptLoginPwd:_text_psw.text pkvalue:passwordKey];
    
    NSString *signedNewPwd = [RSAEncrypt encryptString:_text_newPwd.text publicKey:passwordKey];
    NSString* method = @"GET";
#ifdef LOGIN_USE_POST_ENCRYPT
    
    method = @"POST";
#endif
    
    [self.service loadItemWithAPIName:@"user/modifyPwd.do" params:@{@"phone":_phoneNum, @"newPwd":[signedNewPwd tbUrlEncoded]?:@"", @"validateCode":_smsCode, @"__unNeedEncode__":@1,@"__METHOD__":method} version:nil];
#else
    [self.service loadNumberValueWithAPIName:@"user/modifyPwd.do" params:@{@"phone":_phoneNum,@"newPwd":_text_newPwd.text,@"validateCode":_smsCode} version:nil];
    
#endif
    
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
        [WeAppToast toast:@"找回密码成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];

    }
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
