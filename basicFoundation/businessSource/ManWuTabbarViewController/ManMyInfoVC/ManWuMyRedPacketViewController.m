//
//  ManWuMyRedPacketViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyRedPacketViewController.h"
#import "KSRedPacketModel.h"

#define CELLHEIGHT 100
#define FOOTHEIGHT 30
#define HEADERHEIGHT 30

@interface ManWuMyRedPacketViewController ()
{
    NSMutableArray *redPacketArray;
    NSMutableArray *validRedPackets;
    NSMutableArray *usedRedPackets;    //已使用
    NSMutableArray *expiredRedPackets; //已过期
    NSMutableDictionary *deleteDic;
    MBProgressHUD *_progressHUD;    ///<指示器
    
    CGFloat cellHeight;
}

@end

@implementation ManWuMyRedPacketViewController

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        [_service setItemClass:[KSRedPacketModel class]];
        _service.jsonTopKey = @"data";
        
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    
    self.title = @"我的红包";
    
    validRedPackets = [[NSMutableArray alloc]init];
    usedRedPackets = [[NSMutableArray alloc]init];
    redPacketArray = [[NSMutableArray alloc]init];
    expiredRedPackets = [[NSMutableArray alloc]init];
//    UIBarButtonItem *btn_delete = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAction)];
//    self.navigationItem.rightBarButtonItem = btn_delete;
//    deleteDic = [[NSMutableDictionary alloc]init];

    cellHeight = CELLHEIGHT;
    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.service loadDataListWithAPIName:@"user/myVouchers.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
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
        
        [self.statusHandler removeStatusViewFromView:self.table];
        NSArray *redPackets = [[NSArray alloc]initWithArray:(NSArray*)service.requestModel.dataList];
        if([redPackets count] == 0)
        {
            [self.statusHandler showEmptyViewInView:self.table frame:self.table.bounds];
        }
        for(KSRedPacketModel *redpacket in redPackets)
        {
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//            NSDate *endTime= [dateFormatter dateFromString:redpacket.endTime];
//            NSTimeInterval time = [endTime timeIntervalSinceNow];
//            if(time > 0)
            if([redpacket.status integerValue] == 0)
            {
                [validRedPackets addObject:redpacket];
                
            }else if([redpacket.status integerValue] == 1)
            {
                [usedRedPackets addObject:redpacket];

            }else
            {
                [expiredRedPackets addObject:redpacket];
            }
        }
        redPacketArray = [NSMutableArray arrayWithObjects:validRedPackets, usedRedPackets, expiredRedPackets, nil];
        [self.table reloadData];
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
        [self.statusHandler showViewforError:error inView:self.table frame:self.table.bounds];    
    }
}

#pragma  mark  -tableView Delegate方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [redPacketArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [validRedPackets count];
    }else if(section == 1)
    {
        return [usedRedPackets count];
    }else
    {
        return [expiredRedPackets count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 15;
    }else
        return HEADERHEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section != 0 && [[redPacketArray objectAtIndex:section]count] > 0)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, HEADERHEIGHT)];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(footView.width/2 - 60, 0, 120, HEADERHEIGHT)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        titleLabel.textColor = [TBDetailUIStyle colorWithHexString:@"#999999"];
        [footView addSubview:titleLabel];
        if(section == 1)
        {
            titleLabel.text = @"已使用红包";
            
        }if(section == 2)
        {
            titleLabel.text = @"已过期红包";
        }
        
        UIView *LineView1=[[UIView alloc] initWithFrame:CGRectMake(0, FOOTHEIGHT/2 - 0.5, CGRectGetMinX(titleLabel.frame), 0.5)];
        LineView1.opaque = YES;
        LineView1.backgroundColor = [TBDetailUIStyle colorWithHexString:@"#999999"];
        [footView addSubview:LineView1];
        
        UIView *LineView2=[[UIView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(titleLabel.frame), FOOTHEIGHT/2 - 0.5, footView.width - CGRectGetMaxX(titleLabel.frame), 0.5)];
        LineView2.opaque = YES;
        LineView2.backgroundColor = [TBDetailUIStyle colorWithHexString:@"#999999"];
        [footView addSubview:LineView2];
        
        return footView;
    }
    
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        KSRedPacketModel *redPacketModel = [[redPacketArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CELLHEIGHT - 2*10, CELLHEIGHT - 2*10)];
        [cell.contentView addSubview:headImage];
        
        UILabel *redPacketLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, kSpaceX, 100, 18)];
        [redPacketLabel setFont:[UIFont systemFontOfSize:16]];
        redPacketLabel.text = [NSString stringWithFormat:@"%@元红包",redPacketModel.price];
        [cell.contentView addSubview:redPacketLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, CGRectGetMaxY(redPacketLabel.frame) + 10, SELFWIDTH - CGRectGetMaxX(headImage.frame) - 10, 14)];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        NSString *startTime = [[redPacketModel.startTime componentsSeparatedByString:@" "]objectAtIndex:0];
        NSString *endTime = [[redPacketModel.endTime componentsSeparatedByString:@" "]objectAtIndex:0];
        timeLabel.text = [NSString stringWithFormat:@"有效期：%@至%@",startTime,endTime];
        [cell.contentView addSubview:timeLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, CGRectGetMaxY(timeLabel.frame) + 5,  SELFWIDTH - CGRectGetMaxX(headImage.frame) - 10, 14)];
        [descLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [descLabel setNumberOfLines:0];
        [descLabel setFont:[UIFont systemFontOfSize:12]];
        NSString *descStr = redPacketModel.desc;
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:descStr];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle1 setLineSpacing:5.0];//调整行间距
        // paragraphStyle1.firstLineHeadIndent = textSize20px * 2;//首行缩进
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descStr length])];
        descLabel.attributedText = attributedString1;
        [descLabel sizeToFit];
        [cell.contentView addSubview:descLabel];
        
        cellHeight = 3 * kSpaceX + redPacketLabel.height + timeLabel.height + descLabel.height;
        
        [self tableView:tableView heightForRowAtIndexPath:indexPath];

        if(indexPath.section == 0)
        {
            headImage.image = [UIImage imageNamed:@"hongbao_valid"];
            [redPacketLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
            [timeLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
            [descLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#666666"]];
            
        }else
        {
            headImage.image = [UIImage imageNamed:@"hongbao_invalid"];
            [redPacketLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
            [timeLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
            [descLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];

            UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SELFWIDTH - 65, kSpaceX - 5, 55, 25)];
            if([redPacketModel.status integerValue] == 2)
            {
                stateLabel.text = @"已过期";
            }else if ([redPacketModel.status integerValue] == 1)
            {
                stateLabel.text = @"已使用";
            }
            [stateLabel setFont:[UIFont systemFontOfSize:16]];
            [stateLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#d95c47"]];
            [cell.contentView addSubview:stateLabel];
        }

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


#pragma mark -刷新页面
- (void)refreshDataRequest
{
    [self.service loadDataListWithAPIName:@"user/myVouchers.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
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
