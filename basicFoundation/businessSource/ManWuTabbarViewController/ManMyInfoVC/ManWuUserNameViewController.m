//
//  ManWuUserNameViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuUserNameViewController.h"

@interface ManWuUserNameViewController ()

@end

@implementation ManWuUserNameViewController

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
    self.title = @"用户名";
    
    [self.view addSubview:self.text_userName];
    [self.view addSubview:self.btn_commit];
}

- (MWInsetsTextField *)text_userName
{
    if(!_text_userName)
    {
        _text_userName = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 30, SELFWIDTH, 40)];
        _text_userName.text = [KSUserInfoModel sharedConstant].userName;
        [_text_userName setFont:[UIFont systemFontOfSize:16]];
        _text_userName.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_userName.keyboardType = UIKeyboardTypeNumberPad;
        _text_userName.clearButtonMode = UITextFieldViewModeAlways;
        _text_userName.secureTextEntry = NO;
        _text_userName.delegate = self;
        [_text_userName setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_userName;
}

- (UIButton *)btn_commit
{
    if(!_btn_commit)
    {
        _btn_commit = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_userName.frame) + 30, WIDTH, 40)];
        [_btn_commit setTitle:@"保存" forState:UIControlStateNormal];
        [_btn_commit.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_commit.titleLabel.textColor = [UIColor whiteColor];
        [_btn_commit setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_commit addTarget:self action:@selector(doCommit) forControlEvents:UIControlEventTouchUpInside];
        _btn_commit.enabled = NO;
    }
    
    return _btn_commit;
}

- (void)doCommit
{
    [self.service loadItemWithAPIName:@"user/modifyUser.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"userName":_text_userName.text} version:nil];
}

#pragma mark - UITextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _btn_commit.enabled = YES;
}

#pragma mark - WeAppBasicServiceDelegate method

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
        
        [[KSUserInfoModel sharedConstant]updateUserInfo:dic_userInfo];

        [WeAppToast toast:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
