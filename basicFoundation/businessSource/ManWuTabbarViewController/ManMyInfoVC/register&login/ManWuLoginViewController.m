//
//  ManWuLoginViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/15.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuLoginViewController.h"
#import "ManWuRegisterViewController.h"
#import "ManWuResetPwdViewController.h"
#import "KSUserInfoModel.h"
#import "ManWuLoginContent.h"

@interface ManWuLoginViewController ()

@property (nonatomic,strong) loginActionBlock        loginActionBlock;

@property (nonatomic,strong) cancelActionBlock       cancelActionBlock;

@end

@implementation ManWuLoginViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    self = [self init];
    if (self) {
        self.loginActionBlock = [nativeParams objectForKey:kLoginSuccessBlock];
        self.cancelActionBlock = [nativeParams objectForKey:kLoginCancelBlock];
    }
    return self;
}

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        [_service setItemClass:[NSDictionary class]];
        _service.jsonTopKey = @"data";

    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.navgationView];
    [self.view addSubview:self.logo_imgView];
    [self.view addSubview:self.text_phoneNum];
    [self.view addSubview:self.text_psw];
    [self.view addSubview:self.btn_login];
    [self.view addSubview:self.btn_forgetPwd];
}

- (UIView *)navgationView
{
    if(!_navgationView)
    {
        _navgationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SELFWIDTH, 64)];
        [_navgationView setBackgroundColor:[UIColor redColor]];
        _btn_register = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_register.frame = CGRectMake(SELFWIDTH - 50, 25, 40, 34);
        _btn_register.layer.cornerRadius = 2;
        _btn_register.titleLabel.font = [UIFont systemFontOfSize:15.5f];
        _btn_register.clipsToBounds = YES;
        _btn_register.userInteractionEnabled = YES;
        [_btn_register setTitle:@"注册" forState:UIControlStateNormal];
        [_btn_register addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
        [_navgationView addSubview:_btn_register];
        
        _btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_cancel.frame = CGRectMake(10, 25, 40, 34);
        _btn_cancel.layer.cornerRadius = 2;
        _btn_cancel.titleLabel.font = [UIFont systemFontOfSize:15.5f];
        _btn_cancel.clipsToBounds = YES;
        _btn_cancel.userInteractionEnabled = YES;
        [_btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btn_cancel addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
        [_navgationView addSubview:_btn_cancel];
        
    }
    return _navgationView;
}

- (UIImageView *)logo_imgView
{
    if(!_logo_imgView)
    {
        _logo_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SELFWIDTH/2 - 30, CGRectGetMaxY(_navgationView.frame) + 30, 60, 60)];
        _logo_imgView.backgroundColor = [UIColor redColor];
    }
    return _logo_imgView;
}

- (MWInsetsTextField *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_logo_imgView.frame) + 30, WIDTH, 40)];
        _text_phoneNum.placeholder = @"手机号码/用户名";
        [_text_phoneNum setFont:[UIFont systemFontOfSize:18]];
        _text_phoneNum.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
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
        _text_psw = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_phoneNum.frame) + 15, WIDTH, 40)];
        _text_psw.placeholder = @"密码";
        [_text_psw setFont:[UIFont systemFontOfSize:18]];
        _text_psw.textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _text_psw.keyboardType = UIKeyboardTypeNumberPad;
        _text_psw.clearButtonMode = UITextFieldViewModeAlways;
        _text_psw.secureTextEntry = YES;
        _text_psw.delegate = self;
        [_text_psw setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_psw;
}

- (UIButton *)btn_login
{
    if(!_btn_login)
    {
        _btn_login = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_psw.frame) + 30, WIDTH, 40)];
        [_btn_login setTitle:@"登录" forState:UIControlStateNormal];
        [_btn_login.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_login.titleLabel.textColor = [UIColor whiteColor];
        UIImage *btnImage = [UIImage imageNamed:@"sure-button01.png"];
        btnImage = [btnImage stretchableImageWithLeftCapWidth:floorf(btnImage.size.width/2) topCapHeight:floorf(btnImage.size.height/2)];
        
        UIImage *btnImageselected = [UIImage imageNamed:@"sure-button01-s.png"];
        btnImageselected = [btnImageselected stretchableImageWithLeftCapWidth:floorf(btnImageselected.size.width/2) topCapHeight:floorf(btnImageselected.size.height/2)];
        
        [_btn_login setBackgroundImage:btnImage forState:UIControlStateNormal];
        [_btn_login setBackgroundImage:btnImageselected forState:UIControlStateSelected];
        [_btn_login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_login;
}

- (UIButton *)btn_forgetPwd
{
    if(!_btn_forgetPwd)
    {
        _btn_forgetPwd = [[UIButton alloc]initWithFrame:CGRectMake(SELFWIDTH-kSpaceX-60, CGRectGetMaxY(_btn_login.frame) + 10, 60, 15)];
        [_btn_forgetPwd setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_btn_forgetPwd setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btn_forgetPwd setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_btn_forgetPwd.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _btn_forgetPwd.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn_forgetPwd addTarget:self action:@selector(doResetPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_forgetPwd;
}

- (void)login
{
    //判断逻辑待完善
    if(_text_phoneNum.text.length == 0)
    {
        [WeAppToast toast:@"请输入正确的手机号"];
        return;
    }else if(_text_psw.text.length == 0)
    {
        [WeAppToast toast:@"请输入密码"];
        return;
    }

    [self.service loadItemWithAPIName:@"user/login.do" params:@{@"phone":_text_phoneNum.text, @"pwd":_text_psw.text} version:nil];
}

- (void)doRegister
{
    ManWuRegisterViewController *registerVC = [[ManWuRegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)doResetPwd
{
    ManWuResetPwdViewController *resetPwdVC = [[ManWuResetPwdViewController alloc]init];
    [self.navigationController pushViewController:resetPwdVC animated:YES];
}

- (void)cancelLogin
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.cancelActionBlock) {
        self.cancelActionBlock();
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
        NSDictionary *dic_userInfo = [NSDictionary dictionaryWithDictionary:(NSDictionary*)service.requestModel.item];
        NSLog(@"%@",dic_userInfo);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:dic_userInfo[@"email"] forKey:@"email"];
        [dic setValue:dic_userInfo[@"imgUrl"] forKey:@"imgUrl"];
        [dic setValue:dic_userInfo[@"inviteCode"] forKey:@"inviteCode"];
        [dic setValue:dic_userInfo[@"phone"] forKey:@"phone"];
        [dic setValue:@"" forKey:@"sex"];
        [dic setValue:dic_userInfo[@"userName"] forKey:@"userName"];
        [dic setValue:dic_userInfo[@"userId"] forKey:@"userId"];

        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
        [[NSFileManager defaultManager] createDirectoryAtPath:[LOGIN_FLAG filePathOfCaches] withIntermediateDirectories:YES attributes:nil error:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.loginActionBlock) {
            self.loginActionBlock(YES);
        }
        
//        [self.navigationController popToRootViewControllerAnimated:YES];

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
