//
//  ManWuMyRedPacketViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyRedPacketViewController.h"

#define CELLHEIGHT 120

@interface ManWuMyRedPacketViewController ()
{
    NSMutableArray *redPacketArray;
    NSMutableDictionary *deleteDic;
}

@end

@implementation ManWuMyRedPacketViewController

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
    
    self.title = @"我的红包";
    
    UIBarButtonItem *btn_delete = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAction)];
    
    self.navigationItem.rightBarButtonItem = btn_delete;
    
    [self.service loadItemWithAPIName:@"user/myVouchers.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
    
    deleteDic = [[NSMutableDictionary alloc]init];
}

- (void)deleteAction
{
    UIBarButtonItem *btn_done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(deleteDone)];
    
    self.navigationItem.rightBarButtonItem = btn_done;
    
    [self.table setEditing:YES animated:YES];

}

- (void)deleteDone
{
    
    [redPacketArray removeObjectsInArray:[deleteDic allKeys]];
    
//    [self.table deleteRowsAtIndexPaths:[NSArray arrayWithArray:[deleteDic allValues]] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.table reloadData];
    [deleteDic removeAllObjects];

    UIBarButtonItem *btn_delete = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAction)];
    self.navigationItem.rightBarButtonItem = btn_delete;
    
    [self.table setEditing:NO animated:YES];
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
        redPacketArray = [[NSMutableArray alloc]initWithObjects:@"gg",@"mm",@"zz",@"yy", nil];
        
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
    return [redPacketArray count];
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
    return CELLHEIGHT;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"%ld",indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(kSpaceX, kSpaceX, CELLHEIGHT - 2*kSpaceX, CELLHEIGHT - 2*kSpaceX)];
        headImage.backgroundColor = [UIColor greenColor];
        [cell.contentView addSubview:headImage];
        
        UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SELFWIDTH - 65, kSpaceX - 5, 55, 25)];
        stateLabel.text = @"失效否";
        [stateLabel setFont:[UIFont systemFontOfSize:16]];
        stateLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:stateLabel];
        
        UILabel *redPacketLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, kSpaceX, CGRectGetMinX(stateLabel.frame) - kSpaceX -5, 18)];
        redPacketLabel.text = @"5元";
        [cell.contentView addSubview:redPacketLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, CGRectGetMaxY(redPacketLabel.frame) + 10, SELFWIDTH - CGRectGetMaxX(headImage.frame) - 10, 14)];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithHex:0x666666];
        timeLabel.text = @"有效期";
        [cell.contentView addSubview:timeLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, CGRectGetMaxY(timeLabel.frame) + 10,  SELFWIDTH - CGRectGetMaxX(headImage.frame) - 10, 14)];
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
    [deleteDic setObject:indexPath forKey:[redPacketArray objectAtIndex:indexPath.section]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [deleteDic removeObjectForKey:[redPacketArray objectAtIndex:indexPath.section]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
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
