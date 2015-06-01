//
//  ManWuFeedBackViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/20.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuFeedBackViewController.h"


@interface ManWuFeedBackViewController ()

@end

@implementation ManWuFeedBackViewController

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
    self.title = @"意见反馈";
    [self.view addSubview:self.textView];
    [self.view addSubview:self.btn_commit];
    
}

- (UITextView *)textView
{
    if(!_textView)
    {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(kSpaceX, 30, WIDTH, 100)];
        _textView.keyboardType = UIKeyboardTypeNamePhonePad;
        _textView.backgroundColor = [UIColor clearColor];
    }
    
    return _textView;
}

- (UIButton *)btn_commit
{
    if(!_btn_commit)
    {
        _btn_commit = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(_textView.frame) + 30, WIDTH, 40)];
        [_btn_commit setTitle:@"提交" forState:UIControlStateNormal];
        [_btn_commit.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _btn_commit.titleLabel.textColor = [UIColor whiteColor];
        [_btn_commit setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#dc7868"]] forState:UIControlStateNormal];
        [_btn_commit addTarget:self action:@selector(doFeedBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn_commit;
}

- (void)doFeedBack
{
    NSString *feedBack = _textView.text;
    NSString *userId = @"18867101957";
    [self.service loadItemWithAPIName:@"user/feedback.do" params:@{@"userId":userId,@"suggestion":feedBack} version:nil];
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
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
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
