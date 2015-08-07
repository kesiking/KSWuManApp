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

#import "DataSigner.h"
#import "DataVerifier.h"

#define PUBLICKEY @"AAAAB3NzaC1yc2EAAAABIwAAAQEAtVhJT2fMs3tD52NTJpaFVVWf/0KQYlnwMT786Mxqg34+7ynm98fXNDQryr/GTY7699VGkG/Hez0SGwcNR0/j3zOyS0wnXWL/DvhxWyqDeAxeRJ+ast++jjS8lv94TwtpDg2VwNsHTbjk5ysADU2s8fVeTuSPzjGCCkqi4ijutDNONZDNPrVI+UGBOa1LKCYqepAiF8OQ2xTL8B2qst4/RCSy+2IpYh0x0JyTcxMOIC7OyFe6sUgQDv17yUE83nw60ZrZIhw/Dz+C4ajsgGYPqCln/An0uI+h3eJodCZvex0g9ust2V2d5pzyQMH1QIt42MDZgK0Yf3eO6xzde2XrYQ=="

@interface ManWuLoginViewController ()

@property (nonatomic,strong) loginActionBlock        loginActionBlock;

@property (nonatomic,strong) cancelActionBlock       cancelActionBlock;

@end

@implementation ManWuLoginViewController
{
    MBProgressHUD *_progressHUD;    ///<指示器
    BOOL isKeyShow;//是否有键盘
}

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
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"登录";

    [self.view addSubview:self.logo_imgView];
    [self.view addSubview:self.text_phoneNum];
    [self.view addSubview:self.text_psw];
    [self.view addSubview:self.btn_forgetPwd];
    [self.view addSubview:self.btn_login];
    _btn_register = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_register.frame = CGRectMake(SELFWIDTH - 50, 25, 40, 34);
    _btn_register.layer.cornerRadius = 2;
    _btn_register.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn_register.clipsToBounds = YES;
    _btn_register.userInteractionEnabled = YES;
    [_btn_register setTitle:@"注册" forState:UIControlStateNormal];
    [_btn_register setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn_register addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_btn_register];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_cancel.frame = CGRectMake(10, 25, 40, 34);
    _btn_cancel.layer.cornerRadius = 2;
    _btn_cancel.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn_cancel.clipsToBounds = YES;
    _btn_cancel.userInteractionEnabled = YES;
    [_btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btn_cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn_cancel addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_btn_cancel];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //注册键盘显示通知
    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [center addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *phone = [KSUserInfoModel sharedConstant].phone?:@"";
    if(phone.length != 0)
    {
        _text_phoneNum.text = phone;
    }
}

- (UIImageView *)logo_imgView
{
    if(!_logo_imgView)
    {
        _logo_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SELFWIDTH/2 - 30, 30, 60, 60)];
        _logo_imgView.image = [UIImage imageNamed:@"120.png"];
    }
    return _logo_imgView;
}

- (MWInsetsTextField *)text_phoneNum
{
    if(!_text_phoneNum)
    {
        _text_phoneNum = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logo_imgView.frame) + 30, SELFWIDTH, 40)];
        _text_phoneNum.placeholder = @"手机号码";
        [_text_phoneNum setFont:[UIFont systemFontOfSize:16]];
        _text_phoneNum.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_phoneNum.keyboardType = UIKeyboardTypeNamePhonePad;
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
        _text_psw = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_phoneNum.frame) + 1, SELFWIDTH, 40)];
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

- (UIButton *)btn_forgetPwd
{
    if(!_btn_forgetPwd)
    {
        _btn_forgetPwd = [[UIButton alloc]initWithFrame:CGRectMake(SELFWIDTH-kSpaceX-60, CGRectGetMaxY(_text_psw.frame) + 15, 60, 15)];
        [_btn_forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_btn_forgetPwd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_forgetPwd setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_btn_forgetPwd.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _btn_forgetPwd.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn_forgetPwd addTarget:self action:@selector(doResetPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_forgetPwd;
}

- (UIButton *)btn_login
{
    if(!_btn_login)
    {
        _btn_login = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_btn_forgetPwd.frame) + 20, WIDTH, 40)];
        [_btn_login setTitle:@"登录" forState:UIControlStateNormal];
        [_btn_login.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_login.titleLabel.textColor = [UIColor whiteColor];
        
        [_btn_login setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_login;
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
    CGFloat distance;
    distance=keyBoardRect.origin.y-CGRectGetMaxY(_text_psw.frame) - 64 - 20;
    if (distance<0) {
        [self animationWithUserInfo:notification.userInfo bloack:^{
            if (self.view.frame.size.height <= 480) {
                self.view.transform=CGAffineTransformTranslate(self.view.transform, 0, distance);
            }
            else{
                
                self.view.transform=CGAffineTransformTranslate(self.view.transform, 0, distance - 30);
            }
            
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

- (void)login
{
    //判断逻辑待完善
    if(_text_phoneNum.text.length == 0)
    {
        [WeAppToast toast:@"请输入手机号"];
        return;
        
    }else if(![KSUtils isValidMobile:_text_phoneNum.text])
    {
        [WeAppToast toast:@"请输入正确的手机号"];
        return;
        
    }else if(_text_psw.text.length == 0)
    {
        [WeAppToast toast:@"请输入密码"];
        return;
    }
   
//    id<DataSigner> signer = CreateRSADataSigner(PUBLICKEY);
//    NSString *signedPwd = [signer signString:_text_psw.text];
    
    //初始化指示器
    
    if (!_progressHUD) {
        _progressHUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _progressHUD.detailsLabelText=@"正在登录...";
        _progressHUD.removeFromSuperViewOnHide=YES;
    }

#ifdef LOGIN_NEED_ENCRYPT
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"aliPayfile" ofType:@"plist"];
    NSDictionary* aliPayFile = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if (aliPayFile == nil) {
        aliPayFile = [[NSDictionary alloc] init];
    }
    NSString* passwordKey = [aliPayFile objectForKey:@"passwordKey1"];
    
//    NSString *signedPwd = [KSUtils encryptLoginPwd:_text_psw.text pkvalue:passwordKey];
    
    NSString *signedPwd = [RSAEncrypt encryptString:_text_psw.text publicKey:passwordKey];
    NSString* method = @"GET";
#ifdef LOGIN_USE_POST_ENCRYPT
//    signedPwd = [signedPwd tbUrlEncoded];
    method = @"POST";
#endif
    
    [self.service loadItemWithAPIName:@"user/login.do" params:@{@"phone":_text_phoneNum.text, @"pwd":[signedPwd tbUrlEncoded]?:@"",@"__unNeedEncode__":@1,@"__METHOD__":method} version:nil];
#else
    [self.service loadItemWithAPIName:@"user/login.do" params:@{@"phone":_text_phoneNum.text, @"pwd":_text_psw.text?:@""} version:nil];

#endif
//    [self.service loadItemWithAPIName:@"user/login.do" params:@{@"phone":@"18626876800", @"pwd":@"o3vy2D3n3WDwyHbl3T%2BXV%2FnA4uYNrbAGVdiA%2F3l%2BhyqbS9JeUkLM2rIzn6%2B5TWQp8sSZLqt9fvcKwFw3BcFCEH2fHrw3%2FdKjQwT6TIB%2BHEGkhiLGwvNT9Zq%2BEvLN6NKg7Lv%2F0mfAJNqtwM0k1JbXKwJ5BUaF0wzeXN9QVZfABUU%3D",@"__unNeedEncode__":@1} version:nil];
}

- (void)doRegister
{
    ManWuRegisterViewController *registerVC = [[ManWuRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
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
    if (_progressHUD) {
        [_progressHUD hide:YES];
        _progressHUD = nil;
    }
    if (service == _service) {
        // todo success
        NSDictionary *dic_userInfo = [NSDictionary dictionaryWithDictionary:(NSDictionary*)service.requestModel.item];
        NSLog(@"%@",dic_userInfo);
        [[KSUserInfoModel sharedConstant]updateUserInfo:dic_userInfo];
        [[NSFileManager defaultManager] createDirectoryAtPath:[LOGIN_FLAG filePathOfCaches] withIntermediateDirectories:YES attributes:nil error:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.loginActionBlock) {
            self.loginActionBlock(YES);
        }
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error
{
    if (_progressHUD) {
        [_progressHUD hide:YES];
        _progressHUD = nil;
    }
    if (service == _service) {
        // todo fail
        NSString *errorInfo = @"服务器异常，请稍后再试";
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
