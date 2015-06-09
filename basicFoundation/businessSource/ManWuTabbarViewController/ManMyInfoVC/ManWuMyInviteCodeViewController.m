//
//  ManWuMyInviteCodeViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyInviteCodeViewController.h"

@interface ManWuMyInviteCodeViewController ()
{
    NSMutableArray *inviteCodeArray;
}

@end

@implementation ManWuMyInviteCodeViewController

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
//        [_service setItemClass:[NSDictionary class]];
//        _service.jsonTopKey = @"data";
        
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
    if (service == _service) {
        // todo success
    }
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
        inviteCodeArray = [[NSMutableArray alloc]initWithObjects:@"gg",@"mm", nil];
        
        self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        self.table.delegate = self;
        self.table.dataSource = self;
        [self.view addSubview:self.table];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
    }
}

#pragma  mark  -tableView Delegate方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [inviteCodeArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"%ld",indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(SELFWIDTH - 65, kSpaceX, 60, 30)];
        [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [copyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        copyBtn.layer.cornerRadius = 3.0;
        copyBtn.layer.borderColor = [[UIColor grayColor]CGColor];
        copyBtn.layer.borderWidth = 1.0;
        copyBtn.tag = indexPath.section;
        [copyBtn setBackgroundColor:[UIColor whiteColor]];
        [copyBtn addTarget:self action:@selector(copyInviteCode:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:copyBtn];
        
        UILabel *inviteCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpaceX, kSpaceX, CGRectGetMinX(copyBtn.frame) - kSpaceX -5, 18)];
        inviteCodeLabel.text = @"邀请码：XXXX";
        [cell.contentView addSubview:inviteCodeLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(inviteCodeLabel.frame) + 10, WIDTH, 14)];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithHex:0x666666];
        timeLabel.text = @"有效期";
        [cell.contentView addSubview:timeLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpaceX, CGRectGetMaxY(timeLabel.frame) + 10, WIDTH, 14)];
        [descLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [descLabel setNumberOfLines:0];
        [descLabel setFont:[UIFont systemFontOfSize:12]];
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.textColor = [UIColor colorWithHex:0x666666];
        
        NSString *descStr = @"可获得红包鬼斧神工实际数量和交流是历史环境是谁厉害了深刻数量还是理科好老师时候时候";
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:descStr];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle1 setLineSpacing:6.0];//调整行间距
        // paragraphStyle1.firstLineHeadIndent = textSize20px * 2;//首行缩进
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descStr length])];
        descLabel.attributedText = attributedString1;
        [descLabel sizeToFit];
        
        [cell.contentView addSubview:descLabel];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == 0)
            {
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)copyInviteCode:(id)sender
{
    UIButton *button=(UIButton *)sender;
    NSInteger tag = button.tag;
    UIPasteboard *pasterBoard = [UIPasteboard pasteboardWithName:@"myInviteCode" create:YES];
    pasterBoard.string = [inviteCodeArray objectAtIndex:tag];
    
    NSString * str = pasterBoard.string;
    
    NSLog(@"%@",str);
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
