//
//  ManWuMyOrdersViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/17.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyOrdersViewController.h"
#import "KSOrderModel.h"

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
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];
    self.title = @"我的订单";
    
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
    
    ordersList = @[@[@"1.1",@"1.2",@"1.3"],@[@"2.1",@"2.2",@"2.3"],@[@"3.1",@"3.2",@"3.3"],@[@"4.1",@"4.2",@"4.3"],@[@"5.1",@"5.2",@"5.3"],@[@"6.1",@"6.2",@"6.3"]];
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    r = CGRectZero;
    r.origin.x = 0;
    r.origin.y = CGRectGetMaxY(self.selectionList.frame) + 15;
    r.size.width = rect.size.width;
    r.size.height = rect.size.height - r.origin.y;
    
    self.table = [[UITableView alloc]initWithFrame:r style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];

}

#pragma mark -请求订单数据

- (void)initOrdersList
{
    [self.service loadItemWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
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
    [self.table reloadData];
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
//        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
//        [WeAppToast toast:errorInfo];

    }
}

#pragma  mark  -tableView Delegate方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[ordersList objectAtIndex:self.origIndex] count];
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
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"tableViewCellidentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [[ordersList objectAtIndex:self.origIndex]objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
