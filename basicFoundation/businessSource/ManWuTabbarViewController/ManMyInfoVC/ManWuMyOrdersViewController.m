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

#define ORDERCELLHEIGHT  80

@interface ManWuMyOrdersViewController ()
{
    CGRect r;
    NSArray *ordersList;
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
    
//    ordersList = @[@[@"1.1",@"1.2",@"1.3"],@[@"2.1",@"2.2",@"2.3"],@[@"3.1",@"3.2",@"3.3"],@[@"4.1",@"4.2",@"4.3"],@[@"5.1",@"5.2",@"5.3"],@[@"6.1",@"6.2",@"6.3"]];
    
    CGRect rect = self.view.frame;
    r = CGRectZero;
    r.origin.x = 0;
    r.origin.y = CGRectGetMaxY(self.selectionList.frame) + 15;
    r.size.width = rect.size.width;
    r.size.height = rect.size.height - r.origin.y - 64;
    
    self.table = [[UITableView alloc]initWithFrame:r style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];

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
        [self.service loadDataListWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId, @"status":[NSString stringWithFormat:@"%ld", (long)self.origIndex - 1]} version:nil];
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
    if (service == _service) {
        // todo success
    }
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
        ordersList = (NSArray*)service.requestModel.dataList;
        [self.table reloadData];
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
        return ORDERCELLHEIGHT;

    }else
    {
        return 40;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        NSString *identify = @"orderTableViewCellidentify";

        KSOrderTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(orderCell == nil)
        {
            orderCell = [[KSOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify andFrame:CGRectMake(0, 0, self.view.width, ORDERCELLHEIGHT)];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //在此设置订单列表，以便重新布局
        KSOrderModel *ordermodel = ordersList[indexPath.section];
        orderCell.orderModel = ordermodel;
        return orderCell;
        
    }else
    {
        NSString *identify = @"tableViewCellidentify";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self initTableViewCell:cell RowAtIndexPath:indexPath];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)initTableViewCell:(UITableViewCell *)cell RowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellControlSpacingX, kCellControlSpacingY, 120, kPayFontSize)];
    [payLabel setFont:[UIFont systemFontOfSize:kPayFontSize]];
    [payLabel setTextColor:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"]];
    KSOrderModel *ordermodel = ordersList[indexPath.section];
    NSString *payPriceStr = [NSString stringWithFormat:@"￥%@",ordermodel.payPrice];
    NSString *payStr = [NSString stringWithFormat:@"实付款：%@",payPriceStr];
    NSLog(@"%lu",(unsigned long)[payStr length]);
    NSLog(@"%lu", [[NSString stringWithFormat:@"实付款："]length]);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:payStr];
    [str addAttribute:NSForegroundColorAttributeName value:[TBDetailUIStyle colorWithHexString:@"#b3b3b3"] range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:[TBDetailUIStyle colorWithHexString:@"#000000"] range:NSMakeRange(4,payPriceStr.length)];
    payLabel.attributedText = str;
    [cell.contentView addSubview:payLabel];
    
    
    //设置按钮大小
    UIButton *btn_left = [[UIButton alloc]init];
    [btn_left setTag:indexPath.section];
    UIButton *btn_right = [[UIButton alloc]init];
    [btn_right setTag:indexPath.section];

    NSString *title_leftBtn = [[NSString alloc]init];
    NSString *title_rightBtn = [[NSString alloc]init];
    NSString *statusStr = [[NSString alloc]init];
    
    switch ([ordermodel.status integerValue]) {
        case 0:
        {
            statusStr = @"待付款";
            title_rightBtn = @"支付";
            [btn_right addTarget:self action:@selector(didSelectedButtonStylePay:) forControlEvents:UIControlEventTouchUpInside];
            title_leftBtn = @"取消订单";
            [btn_left addTarget:self action:@selector(didSelectedButtonStyleCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            statusStr = @"待发货";
            title_leftBtn = @"";
            title_rightBtn = @"提醒发货";
            [btn_right addTarget:self action:@selector(didSelectedButtonStyleNoteSend:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        {
            statusStr = @"待收货";
            title_leftBtn = @"取消订单";
            [btn_left addTarget:self action:@selector(didSelectedButtonStyleCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
            title_rightBtn = @"物流单号";
            [btn_right addTarget:self action:@selector(didSelectedButtonStyleLogisticsInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 3:
        {
            statusStr = @"已收货";
            title_leftBtn = @"";
            title_rightBtn = @"删除订单";
            [btn_right addTarget:self action:@selector(didSelectedButtonStyleDeleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 4:
        {
            statusStr = @"退/换货";
            title_leftBtn = @"";
            title_rightBtn = @"查看进度";
            [btn_right addTarget:self action:@selector(didSelectedButtonStyleScheduleInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        default:
            break;
    }
    CGSize btn_rightSize = [title_rightBtn sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    CGFloat btn_rightX = self.view.width - kCellControlSpacingX - btn_rightSize.width - 30;
    CGFloat btn_rightY = kCellControlSpacingX;
    CGRect btn_rightRect=CGRectMake(btn_rightX, btn_rightY, btn_rightSize.width + 30, btn_rightSize.height + 10);
    
    [btn_right setFrame:btn_rightRect];
    [btn_right.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
    [btn_right setTitle:title_rightBtn forState:UIControlStateNormal];
    btn_right.layer.borderWidth = 0.5;
    btn_right.layer.cornerRadius = 3;
    if([title_rightBtn isEqualToString:@"支付"] || [title_rightBtn isEqualToString:@"提醒发货"] || [title_rightBtn isEqualToString:@"物流单号"])
    {
        [btn_right setTitleColor:[TBDetailUIStyle colorWithHexString:@"#d95c47"] forState:UIControlStateNormal];
        btn_right.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#d95c47"]CGColor];
    }else
    {
        [btn_right setTitleColor:[TBDetailUIStyle colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn_right.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#666666"]CGColor];
    }
    
    if([title_leftBtn length] == 0)
    {
        btn_left.enabled = NO;
    }else
    {
        CGSize btn_leftSize = [title_rightBtn sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kButtonFontSize]}];
        CGFloat btn_leftX = CGRectGetMinX(btn_right.frame) - btn_leftSize.width - 30 - 20;
        CGFloat btn_leftY = kCellControlSpacingX;
        CGRect btn_leftRect=CGRectMake(btn_leftX, btn_leftY, btn_leftSize.width + 30, btn_leftSize.height + 10);
        [btn_left setFrame:btn_leftRect];
        [btn_left.titleLabel setFont:[UIFont systemFontOfSize:kButtonFontSize]];
        [btn_left setTitle:title_leftBtn forState:UIControlStateNormal];
        [btn_left setTitleColor:[TBDetailUIStyle colorWithHexString:@"666666"] forState:UIControlStateNormal];
        btn_left.layer.borderWidth = 0.5;
        btn_left.layer.cornerRadius = 3;
        btn_left.layer.borderColor = [[TBDetailUIStyle colorWithHexString:@"#666666"]CGColor];
    }
    
    [cell.contentView addSubview:btn_right];
    [cell.contentView addSubview:btn_left];
}

- (void)didSelectedButtonStylePay:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
    
}

- (void)didSelectedButtonStyleCancelOrder:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
}

- (void)didSelectedButtonStyleNoteSend:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
}

- (void)didSelectedButtonStyleDeleteOrder:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
}

- (void)didSelectedButtonStyleLogisticsInfo:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
}

- (void)didSelectedButtonStyleScheduleInfo:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger orderNum = button.tag;
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
