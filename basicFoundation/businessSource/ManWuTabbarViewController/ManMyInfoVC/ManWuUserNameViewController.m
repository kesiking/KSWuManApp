//
//  ManWuUserNameViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuUserNameViewController.h"
#import "KSDropDownListView.h"

@interface ManWuUserNameViewController ()
{
    KSDropDownListView *dropdownListSex;
    NSString *textString;
}

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
    switch (self.configStyle) {
        case UserInfoConfigUserNameStyle:
            self.title = @"用户名";
            textString = [KSUserInfoModel sharedConstant].userName?:@"";
            if([[KSUserInfoModel sharedConstant].userName length] == 0)
            {
                textString = @"请输入用户名";
            }
            [self.view addSubview:self.text_userInfo];
            [self.view addSubview:self.btn_commit];
            break;
        case UserInfoConfigSexStyle:
            self.title = @"性别";
            dropdownListSex = [[KSDropDownListView alloc]initWithFrame:CGRectMake(0, 30, self.view.width, TEXTFILEDHEIGHT*3) CellHeight:TEXTFILEDHEIGHT];
            dropdownListSex.cellHeight = TEXTFILEDHEIGHT;
            dropdownListSex.userActionLabel.text = [KSUserInfoModel sharedConstant].sex?:@"男";
            if([[KSUserInfoModel sharedConstant].sex length] == 0)
            {
                dropdownListSex.userActionLabel.text = @"男";
            }
            dropdownListSex.dataArray = @[@"男",@"女"];
            [self.view addSubview:dropdownListSex];
            [self.view addSubview:self.btn_commit];
            break;
        case UserInfoConfigEmailStyle:
            self.title = @"邮箱";
            textString = [KSUserInfoModel sharedConstant].email?:@"";
            if([[KSUserInfoModel sharedConstant].email length] == 0)
            {
                textString = @"请输入邮箱";
            }
            [self.view addSubview:self.text_userInfo];
            [self.view addSubview:self.btn_commit];
            break;
        default:
            break;
    }
}

- (MWInsetsTextField *)text_userInfo
{
    if(!_text_userInfo)
    {
        _text_userInfo = [[MWInsetsTextField alloc]initWithFrame:CGRectMake(0, 30, SELFWIDTH, TEXTFILEDHEIGHT)];
        _text_userInfo.placeholder = textString;
        [_text_userInfo setFont:[UIFont systemFontOfSize:16]];
        _text_userInfo.textEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _text_userInfo.keyboardType = UIKeyboardTypeNamePhonePad;
        _text_userInfo.clearButtonMode = UITextFieldViewModeAlways;
        _text_userInfo.secureTextEntry = NO;
        _text_userInfo.delegate = self;
        [_text_userInfo setBackgroundColor:[UIColor whiteColor]];
    }
    return _text_userInfo;
}

- (UIButton *)btn_commit
{
    if(!_btn_commit)
    {
        if(self.configStyle == UserInfoConfigSexStyle)
        {
            _btn_commit = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(dropdownListSex.frame) + 30, WIDTH, 40)];

        }else
        {
            _btn_commit = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_text_userInfo.frame) + 30, WIDTH, 40)];
        }

        [_btn_commit setTitle:@"保存" forState:UIControlStateNormal];
        [_btn_commit.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_commit.titleLabel.textColor = [UIColor whiteColor];
        [_btn_commit setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_commit addTarget:self action:@selector(doCommit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_commit;
}

- (void)doCommit
{
    NSString *sexValue;
    switch (self.configStyle) {
        case UserInfoConfigUserNameStyle:
            [self.service loadItemWithAPIName:@"user/modifyUser.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"userName":_text_userInfo.text} version:nil];
            break;
        case UserInfoConfigSexStyle:
            
            if([dropdownListSex.userActionLabel.text isEqualToString:@"男"])
            {
                sexValue = @"1";
            }else
            {
                sexValue = @"0";
            }
            [self.service loadItemWithAPIName:@"user/modifyUser.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"sex":sexValue} version:nil];
            break;
        case UserInfoConfigEmailStyle:
            [self.service loadItemWithAPIName:@"user/modifyUser.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"email":_text_userInfo.text} version:nil];
            break;
        default:
            break;
    }
}

#pragma mark 监听View点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
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
