//
//  ManWuChangePwdViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/19.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuChangePwdViewController.h"

@interface ManWuChangePwdViewController ()

@end

@implementation ManWuChangePwdViewController

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
    self.title = @"修改密码";
    [self.view addSubview:self.text_oldPwd];
    [self.view addSubview:self.text_newPwd];
    [self.view addSubview:self.text_renewPwd];
    [self.view addSubview:self.btn_commit];

}

- (MWInsetsTextField *)text_oldPwd
{
    if(!_text_oldPwd)
    {
        _text_oldPwd = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 15, SELFWIDTH, 40)];
        _text_oldPwd.placeholder = @"原始密码";
        [_text_oldPwd setFont:[UIFont systemFontOfSize:16]];
        _text_oldPwd.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_oldPwd.keyboardType = UIKeyboardTypeNumberPad;
        _text_oldPwd.clearButtonMode = UITextFieldViewModeAlways;
        _text_oldPwd.secureTextEntry = YES;
        _text_oldPwd.delegate = self;
        [_text_oldPwd setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_oldPwd;
}

- (MWInsetsTextField *)text_newPwd
{
    if(!_text_newPwd)
    {
        _text_newPwd = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_oldPwd.frame) + 1, SELFWIDTH, 40)];
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
        _text_renewPwd = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_text_newPwd.frame) + 1, SELFWIDTH, 40)];
        _text_renewPwd.placeholder = @"重新输入新密码";
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


- (UIButton *)btn_commit
{
    if(!_btn_commit)
    {
        _btn_commit = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_renewPwd.frame) + 30, WIDTH, 40)];
        [_btn_commit setTitle:@"提交" forState:UIControlStateNormal];
        [_btn_commit.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_commit.titleLabel.textColor = [UIColor whiteColor];
        [_btn_commit setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_commit addTarget:self action:@selector(doChangePwd) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_commit;
}

#pragma mark 监听View点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}

- (void)doChangePwd
{
    if([_text_oldPwd.text length] == 0)
    {
        [WeAppToast toast:@"请输入原始密码"];
        return;
    }
    if([_text_newPwd.text length] == 0)
    {
        [WeAppToast toast:@"请输入新密码"];
        return;
    }
    if([_text_renewPwd.text length] == 0)
    {
        [WeAppToast toast:@"请确认新密码"];
        return;
    }
    if(![_text_newPwd.text isEqualToString:_text_renewPwd.text])
    {
        [WeAppToast toast:@"新密码输入不一致"];
        return;
    }

    [self.service loadItemWithAPIName:@"user/reset.do" params:@{@"phone":[KSUserInfoModel sharedConstant].phone,@"pwd":_text_oldPwd.text,@"newPwd":_text_newPwd.text} version:nil];
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
        [WeAppToast toast:@"修改密码成功"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[LOGIN_FLAG filePathOfCaches] error:nil];
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
