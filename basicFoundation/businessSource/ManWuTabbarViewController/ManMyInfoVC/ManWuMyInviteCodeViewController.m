//
//  ManWuMyInviteCodeViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyInviteCodeViewController.h"
#import "KSInviteCodeModel.h"

@interface ManWuMyInviteCodeViewController ()
{
    NSDictionary *inviteCodeModel;
    UIView *inviteCodeView;
    MBProgressHUD *_progressHUD;    ///<指示器
}

@end

@implementation ManWuMyInviteCodeViewController

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
    
    self.title = @"我的邀请码";
    
    [self.service loadItemWithAPIName:@"user/inviteCode.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
}

#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service
{
    //初始化指示器
    
    if (!_progressHUD) {
        _progressHUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _progressHUD.detailsLabelText=@"努力加载中...";
        _progressHUD.removeFromSuperViewOnHide=YES;
    }

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
        [self.statusHandler removeStatusViewFromView:self.view];
        inviteCodeModel = [[NSDictionary alloc]initWithDictionary:(NSDictionary *)service.requestModel.item];
        
        if(inviteCodeModel == nil)
        {
            [self.statusHandler showEmptyViewInView:self.view frame:self.view.bounds];
            
        }else
        {
            [self initInviteCodeView];
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
        [self.statusHandler showViewforError:error inView:self.view frame:self.view.bounds];
    }
}

- (void)initInviteCodeView
{
    UIButton *copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(SELFWIDTH - 65, kSpaceX, 55, 25)];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    copyBtn.layer.cornerRadius = 3.0;
    copyBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    copyBtn.layer.borderWidth = 1.0;
    [copyBtn setBackgroundColor:[UIColor whiteColor]];
    [copyBtn addTarget:self action:@selector(copyInviteCode:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *inviteCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpaceX, kSpaceX, CGRectGetMinX(copyBtn.frame) - kSpaceX -5, 18)];
    NSString *inviteCodeStr = inviteCodeModel[@"inviteCode"];
    NSString *inviteStr = [NSString stringWithFormat:@"邀请码：%@",inviteCodeStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:inviteStr];
    [str addAttribute:NSForegroundColorAttributeName value:[TBDetailUIStyle colorWithHexString:@"#666666"] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[TBDetailUIStyle colorWithHexString:@"#d95c47"] range:NSMakeRange(4,inviteCodeStr.length)];
    inviteCodeLabel.attributedText = str;
    
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(inviteCodeLabel.frame) + 10, WIDTH, 14)];
    [descLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [descLabel setNumberOfLines:0];
    [descLabel setFont:[UIFont systemFontOfSize:12]];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor colorWithHex:0x666666];
    
    NSString *descStr = inviteCodeModel[@"description"];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:descStr];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle1 setLineSpacing:10.0];//调整行间距
    // paragraphStyle1.firstLineHeadIndent = textSize20px * 2;//首行缩进
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descStr length])];
    descLabel.attributedText = attributedString1;
    [descLabel sizeToFit];
    
    inviteCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, self.view.width, 40 + inviteCodeLabel.height + descLabel.height)];
    [inviteCodeView setBackgroundColor:[TBDetailUIStyle colorWithHexString:@"#ffffff"]];
    [inviteCodeView addSubview:copyBtn];
    [inviteCodeView addSubview:inviteCodeLabel];
    [inviteCodeView addSubview:descLabel];
    
    [self.view addSubview:inviteCodeView];

}

- (void)copyInviteCode:(id)sender
{
//    UIPasteboard *pasterBoard = [UIPasteboard pasteboardWithName:@"myInviteCode" create:YES];
    UIPasteboard *pasterBoard = [UIPasteboard generalPasteboard];
    pasterBoard.string = inviteCodeModel[@"inviteCode"];
//    
//    NSString * str = pasterBoard.string;
//    
//    NSLog(@"%@",str);
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
