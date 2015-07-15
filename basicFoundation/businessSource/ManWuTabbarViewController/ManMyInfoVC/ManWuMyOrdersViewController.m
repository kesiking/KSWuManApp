//
//  ManWuMyOrdersViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyOrdersViewController.h"
#import "KSOrderModel.h"
#import "KSOrderTableViewCell.h"
#import "ManWuOrderDetailViewController.h"
#import "KSSafePayUtility.h"


#define ORDERCELLHEIGHT  80

@interface ManWuMyOrdersViewController ()<UIAlertViewDelegate>
{
    CGRect r;
    NSArray *ordersList;
    MBProgressHUD *_progressHUD;    ///<指示器
    UIAlertView *myAlertView;
    CGFloat cellHeight;
}

@end

@implementation ManWuMyOrdersViewController

-(KSAdapterService *)service{
    if (_service == nil) {
        _service = [[KSAdapterService alloc] init];
        _service.delegate = self;
        [_service setItemClass:[KSOrderModel class]];
        _service.jsonTopKey = @"data";
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"我的订单";
    
    ordersList = [[NSArray alloc]init];
    
    [self initOrdersList];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.selectionList.selectionIndicatorStyle = HTHorizontalSelectionIndicatorStyleBottomBar;
    self.selectionList.selectedButtonIndex = self.origIndex;
    self.selectionList.selectionIndicatorColor = [UIColor redColor];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.orderMarks = @[@"全部订单",
                      @"待付款",
                      @"待发货",
                      @"待收货",
                      @"已收货",
                      @"退/换货"];
    
    [self.view addSubview:self.selectionList];
    
    cellHeight = ORDERCELLHEIGHT;
    
    CGRect rect = self.view.frame;
    r = CGRectZero;
    r.origin.x = 0;
    r.origin.y = CGRectGetMaxY(self.selectionList.frame) + 15;
    r.size.width = rect.size.width;
    r.size.height = rect.size.height - r.origin.y;
    
    self.table = [[UITableView alloc]initWithFrame:r style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    __block __weak __typeof(self) tempSelf = self;
    
    [self.table addPullToRefreshWithActionHandler:^{
        __strong __typeof(self) strongSelf = tempSelf;
        
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if ([strongSelf.table showsPullToRefresh]) {
                //判断是否已经被取消刷新，避免出现crash
                [strongSelf refreshDataRequest];
                [strongSelf.table.pullToRefreshView stopAnimating];
            }
        });
    }];
    
    [self.view bringSubviewToFront:self.selectionList];
}

#pragma mark -请求订单数据

- (void)initOrdersList
{
//    [self.service loadItemWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
    
    if(self.origIndex == 0)
    {
        [self.service loadDataListWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
        
    }else
    {
        [self.service loadDataListWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId, @"status":[NSString stringWithFormat:@"%ld", (long)self.origIndex]} version:nil];
    }
}

#pragma mark -UIScrollView Protocol Methods

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGRect rect = [[UIScreen mainScreen]bounds];
//    NSUInteger offx =    scrollView.contentOffset.x;
//    NSUInteger index = offx / rect.size.width;
//    [self.selectionList setHorizonalSelect:index];
//}


#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.orderMarks.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.orderMarks[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    
    self.origIndex = index;
    
    [self initOrdersList];
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
        
        if([service.requestModel.apiName isEqualToString:@"order/modifyOrder.do"])
        {
            [self initOrdersList];
            return;
        }
        [self.statusHandler removeStatusViewFromView:self.table];
        ordersList = (NSArray*)service.requestModel.dataList;
        
        if([ordersList count] == 0)
        {
            [self.statusHandler showEmptyViewInView:self.table frame:self.table.bounds];
        }
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
    return [ordersList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return cellHeight;

    }else
    {
        return 40;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        KSOrderTableViewCell *orderCell;
        //= [tableView dequeueReusableCellWithIdentifier:OrderTableCellStyleInfo];
        if(orderCell == nil)
        {
            orderCell = [[KSOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderTableCellStyleInfo andFrame:CGRectMake(0, 0, self.view.width, ORDERCELLHEIGHT)];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //在此设置订单列表，以便重新布局
        KSOrderModel *ordermodel = ordersList[indexPath.section];
        orderCell.orderModel = ordermodel;
        cellHeight = orderCell.height;
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        return orderCell;
        
    }else
    {
        KSOrderTableViewCell *cell;
        //= [tableView dequeueReusableCellWithIdentifier:OrderTableCellStyleDeal];
        if(cell == nil)
        {
            cell = [[KSOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderTableCellStyleDeal andFrame:CGRectMake(0, 0, self.view.width, 40)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [self initTableViewCell:cell RowAtIndexPath:indexPath];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
        ManWuOrderDetailViewController *orderDetailVC = [[ManWuOrderDetailViewController alloc]init];
        orderDetailVC.orderModel = [ordersList objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
}

- (void)initTableViewCell:(KSOrderTableViewCell *)cell RowAtIndexPath:(NSIndexPath *)indexPath
{
//    UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellControlSpacingX, kCellControlSpacingY, 120, kPayFontSize)];
//    [payLabel setFont:[UIFont systemFontOfSize:kPayFontSize]];
//    [payLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    KSOrderModel *ordermodel = ordersList[indexPath.section];
    NSString *payPriceStr = [NSString stringWithFormat:@"￥%@",ordermodel.payPrice];
    NSString *payStr = [NSString stringWithFormat:@"实付款：%@",payPriceStr];
    NSLog(@"%lu",(unsigned long)[payStr length]);
    NSLog(@"%lu", [[NSString stringWithFormat:@"实付款："]length]);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:payStr];
    [str addAttribute:NSForegroundColorAttributeName value:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"] range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:[TBDetailUIStyle colorWithHexString:@"#000000"] range:NSMakeRange(4,payPriceStr.length)];
    cell.payLabel.attributedText = str;
    
    
    //设置按钮大小
//    UIButton *btn_left = [[UIButton alloc]init];
    [cell.btn_left setTag:indexPath.section];
//    UIButton *btn_right = [[UIButton alloc]init];
    [cell.btn_right setTag:indexPath.section];

    NSString *title_leftBtn = [[NSString alloc]init];
    NSString *title_rightBtn = [[NSString alloc]init];
    NSString *statusStr = [[NSString alloc]init];
    
    switch ([ordermodel.status integerValue]) {
        case 1:
        {
            statusStr = @"待付款";
            title_rightBtn = @"支付";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStylePay:) forControlEvents:UIControlEventTouchUpInside];
            title_leftBtn = @"取消订单";
            [cell.btn_left addTarget:self action:@selector(didSelectedButtonStyleCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        {
            statusStr = @"待发货";
            title_leftBtn = @"";
            title_rightBtn = @"提醒发货";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStyleNoteSend:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 3:
        {
            statusStr = @"待收货";
            title_leftBtn = @"";
            title_rightBtn = @"物流单号";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStyleLogisticsInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 4:
        {
            statusStr = @"已收货";
            title_leftBtn = @"";
            title_rightBtn = @"删除订单";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStyleDeleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 5:
        {
            statusStr = @"退款中";
            title_leftBtn = @"";
            title_rightBtn = @"查看进度";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStyleScheduleInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 6:
        {
            statusStr = @"已退款";
            title_leftBtn = @"";
            title_rightBtn = @"查看进度";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStyleScheduleInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 7:
        {
            statusStr = @"已取消";
            title_leftBtn = @"";
            title_rightBtn = @"删除订单";
            [cell.btn_right addTarget:self action:@selector(didSelectedButtonStyleDeleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        default:
            break;
    }
    CGSize btn_rightSize = [title_rightBtn sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    CGFloat btn_rightX = self.view.width - kCellControlSpacingX - btn_rightSize.width - 30;
    CGFloat btn_rightY = kCellControlSpacingX;
    CGRect btn_rightRect=CGRectMake(btn_rightX, btn_rightY, btn_rightSize.width + 30, btn_rightSize.height + 10);
    
    [cell.btn_right setFrame:btn_rightRect];
    [cell.btn_right.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
    [cell.btn_right setTitle:title_rightBtn forState:UIControlStateNormal];
    cell.btn_right.layer.borderWidth = 0.5;
    cell.btn_right.layer.cornerRadius = 3;
    if([title_rightBtn isEqualToString:@"支付"] || [title_rightBtn isEqualToString:@"提醒发货"] || [title_rightBtn isEqualToString:@"物流单号"])
    {
        [cell.btn_right setTitleColor:[TBDetailUIStyle colorWithHexString:@"#d95c47"] forState:UIControlStateNormal];
        cell.btn_right.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#d95c47"]CGColor];
    }else
    {
        [cell.btn_right setTitleColor:[TBDetailUIStyle colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        cell.btn_right.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#666666"]CGColor];
    }
    
    if([title_leftBtn length] == 0)
    {
        cell.btn_left.enabled = NO;
        [cell.btn_left removeFromSuperview];
    }else
    {
        CGSize btn_leftSize = [title_leftBtn sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        CGFloat btn_leftX = CGRectGetMinX(cell.btn_right.frame) - btn_leftSize.width - 30 - 20;
        CGFloat btn_leftY = kCellControlSpacingX;
        CGRect btn_leftRect=CGRectMake(btn_leftX, btn_leftY, btn_leftSize.width + 30, btn_leftSize.height + 10);
        [cell.btn_left setFrame:btn_leftRect];
        [cell.btn_left.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
        [cell.btn_left setTitle:title_leftBtn forState:UIControlStateNormal];
        [cell.btn_left setTitleColor:[TBDetailUIStyle colorWithHexString:@"666666"] forState:UIControlStateNormal];
        cell.btn_left.layer.borderWidth = 0.5;
        cell.btn_left.layer.cornerRadius = 3;
        cell.btn_left.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#666666"]CGColor];
    }
}

#pragma mark - 支付

- (void)didSelectedButtonStylePay:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
    
    KSOrderModel *orderModel = [ordersList objectAtIndex:orderNum];
    
    NSDictionary* params = @{@"tradeNO":orderModel.orderId?:@"",@"productName":orderModel.title?:@"",@"productDescription":orderModel.title?:@"",@"price":[NSString stringWithFormat:@"%@",orderModel.payPrice?:@0.01]};
    
    [KSSafePayUtility aliPayForParams:params callbackBlock:^(NSDictionary *resultDic) {
        // 支付成功后 todo
        NSLog(@"++++++++++++++支付成功");
    }];

}

#pragma mark - 取消订单

- (void)didSelectedButtonStyleCancelOrder:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
    
    myAlertView = [[UIAlertView alloc]initWithTitle:@"是否取消订单？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    myAlertView.tag = orderNum*100 + 7;
    [myAlertView show];
}

#pragma mark - 提醒发货

- (void)didSelectedButtonStyleNoteSend:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
    
    KSOrderModel *orderModel = [ordersList objectAtIndex:orderNum];
    
    [self.service loadItemWithAPIName:@"order/modifyOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"orderId":orderModel.orderId,@"status":@2} version:nil];
}

#pragma mark - 删除订单

- (void)didSelectedButtonStyleDeleteOrder:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
    
    myAlertView = [[UIAlertView alloc]initWithTitle:@"是否删除订单？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    myAlertView.tag = orderNum*100 + 8;
    [myAlertView show];

}

#pragma mark - 物流单号

- (void)didSelectedButtonStyleLogisticsInfo:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
}

#pragma mark - 查看进度

- (void)didSelectedButtonStyleScheduleInfo:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
}

#pragma mark - 页面刷新

- (void)refreshDataRequest
{
    if(self.origIndex == 0)
    {
        [self.service loadDataListWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
        
    }else
    {
        [self.service loadDataListWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId, @"status":[NSString stringWithFormat:@"%ld", (long)self.origIndex]} version:nil];
    }
}

#pragma mark - alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger orderNum = alertView.tag/100;
    NSInteger toStatus = alertView.tag%100;
    
    if(buttonIndex == 0)
    {
        return;
        
    }else
    {
        switch (toStatus) {
            case 7:
            {
                //取消订单操作
                KSOrderModel *orderModel = [ordersList objectAtIndex:orderNum];
                
                [self.service loadItemWithAPIName:@"order/modifyOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"orderId":orderModel.orderId,@"status":@7} version:nil];
            }
                break;
            case 8:
            {
                //取消订单操作
                KSOrderModel *orderModel = [ordersList objectAtIndex:orderNum];
                
                [self.service loadItemWithAPIName:@"order/modifyOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"orderId":orderModel.orderId,@"status":@8} version:nil];
            }
                break;

                
            default:
                break;
        }
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
