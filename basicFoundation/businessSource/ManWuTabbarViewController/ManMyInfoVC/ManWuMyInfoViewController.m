//
//  ManWuMyInfoViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuMyInfoViewController.h"
#import "ManWuRegisterViewController.h"
#import "ManWuLoginViewController.h"
#import "ManWuPersonInfoViewController.h"
#import "ManWuMyOrdersViewController.h"
#import "ManWuConfigViewController.h"
#import "ManWuMyRedPacketViewController.h"
#import "ManWuMyInviteCodeViewController.h"
#import "KSOrderModel.h"

@implementation ManWuMyInfoViewController
{
    UIImageView *headImageView;
    UILabel *lab_userName;
    UIImageView *sexImageView ;
    NSArray *dataSource;
    NSArray *orderImageArray;
    NSArray *orderNameArray;
    BOOL isAlreadyLogined;
    NSMutableArray *userItems;
    NSInteger forPayNum;
    NSInteger forSendNum;
    NSInteger forReceiveNum;
    NSInteger receivedNum;
    NSInteger forChangeNum;
    UserInfoViewItem *forPayItem;
    UserInfoViewItem *forSendItem;
    UserInfoViewItem *forReceiveItem;
    UserInfoViewItem *receivedItem;
    UserInfoViewItem *forChangeItem;

}

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
    forPayNum = 0; forSendNum = 0; forReceiveNum = 0; receivedNum = 0; forChangeNum = 0;
    [self.view setBackgroundColor:[TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ButtonDisabled]];

    self.navigationItem.title = @"我的";
    dataSource = @[@[@"CSLineLayout"],@[@"CSLineLayout",@"全部订单"],@[@"常用收货地址",@"我的收藏",@"我的红包",@"我的邀请码"]];
    orderImageArray = @[@"order_forpay",@"order_forsend",@"order_forreceive",@"order_received",@"order_forchange"];
    orderNameArray = @[@"待付款",@"待发货",@"待收货",@"已收货",@"退款"];

    [self initCSLineLayoutView];

    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    // 查看是否登陆，如果未登陆则跳出登陆
    [self checkLogin];
    [self initOrdersData];
    [self initUserInfoView];
}

-(void)setupNavigationBar{
    UINavigationController* navigationController = self.navigationController;
    if([navigationController.navigationBar respondsToSelector:@selector(barTintColor)]){
        navigationController.navigationBar.barTintColor = RGB(0xf8, 0xf8, 0xf8);
    }
    if([navigationController.navigationBar respondsToSelector:@selector(tintColor)]){
        navigationController.navigationBar.tintColor  =  RGB(0x66, 0x66, 0x66);
    }
    
    // 修改navbar title颜色
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               RGB(0x66, 0x66, 0x66), NSForegroundColorAttributeName,
                                               [UIFont boldSystemFontOfSize:18], NSFontAttributeName,nil];
    [navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];

}

- (void)viewDidAppear:(BOOL)animated
{
    _btn_config = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_config.frame = CGRectMake(SELFWIDTH - 40, 12, 20, 20);
    [_btn_config setBackgroundImage:[UIImage imageNamed:@"btn_config"] forState:UIControlStateNormal];
    [_btn_config addTarget:self action:@selector(gotoConfig) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_btn_config];

}

- (void)viewWillDisappear:(BOOL)animated
{
    if(_btn_config)
    {
        [_btn_config removeFromSuperview];
    }
}

- (void)initOrdersData
{
    [self.service loadDataListWithAPIName:@"order/myOrders.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId} version:nil];
}

- (void)initCSLineLayoutView
{
    _myInfoContainer = [[CSLinearLayoutView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 71)];
    _myInfoContainer.orientation = CSLinearLayoutViewOrientationHorizontal;
    _myInfoContainer.scrollEnabled = YES;
    CGFloat padding = (self.view.width / 5.0 - 50)/2;
    // add ten views
    CSLinearLayoutItem *item;
    for (int i=0; i<5; i++) {
        switch (i) {
            case 0:
                forPayItem = [[UserInfoViewItem alloc]initWithFrame:CGRectMake(0.0, 0.0, 50.0, 51.0) Tag:i];
                forPayItem.delegate = self;
                forPayItem.itemImageView.image = [UIImage imageNamed:[orderImageArray objectAtIndex:i]];
                forPayItem.itemName.text = [orderNameArray objectAtIndex:i];
                item = [CSLinearLayoutItem layoutItemForView:forPayItem];
                break;
            case 1:
                forSendItem = [[UserInfoViewItem alloc]initWithFrame:CGRectMake(0.0, 0.0, 50.0, 51.0) Tag:i];
                forSendItem.delegate = self;
                forSendItem.itemImageView.image = [UIImage imageNamed:[orderImageArray objectAtIndex:i]];
                forSendItem.itemName.text = [orderNameArray objectAtIndex:i];
                item = [CSLinearLayoutItem layoutItemForView:forSendItem];
                break;
            case 2:
                forReceiveItem = [[UserInfoViewItem alloc]initWithFrame:CGRectMake(0.0, 0.0, 50.0, 51.0) Tag:i];
                forReceiveItem.delegate = self;
                forReceiveItem.itemImageView.image = [UIImage imageNamed:[orderImageArray objectAtIndex:i]];
                forReceiveItem.itemName.text = [orderNameArray objectAtIndex:i];
                item = [CSLinearLayoutItem layoutItemForView:forReceiveItem];
                break;
            case 3:
                receivedItem = [[UserInfoViewItem alloc]initWithFrame:CGRectMake(0.0, 0.0, 50.0, 51.0) Tag:i];
                receivedItem.delegate = self;
                receivedItem.itemImageView.image = [UIImage imageNamed:[orderImageArray objectAtIndex:i]];
                receivedItem.itemName.text = [orderNameArray objectAtIndex:i];
                item = [CSLinearLayoutItem layoutItemForView:receivedItem];
                break;
            case 4:
                forChangeItem = [[UserInfoViewItem alloc]initWithFrame:CGRectMake(0.0, 0.0, 50.0, 51.0) Tag:i];
                forChangeItem.delegate = self;
                forChangeItem.itemImageView.image = [UIImage imageNamed:[orderImageArray objectAtIndex:i]];
                forChangeItem.itemName.text = [orderNameArray objectAtIndex:i];
                item = [CSLinearLayoutItem layoutItemForView:forChangeItem];
                break;
                
            default:
                break;
        }
        item.padding = CSLinearLayoutMakePadding(10.0, padding,10.0, padding);
        item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
        item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
        [_myInfoContainer addItem:item];
    }
}

- (void)initUserInfoView
{
    if(!_userInfoView)
    {
        _userInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    }
    if(!headImageView)
    {
         headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, _userInfoView.height/2 - 30, 60, 60)];
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = headImageView.frame.size.width * 0.5;
        [_userInfoView addSubview:headImageView];
    }
    if([[KSUserInfoModel sharedConstant].imgUrl length] == 0)
    {
        headImageView.image = [UIImage imageNamed:@"defaultHead"];
    }else
    {
        [headImageView sd_setImageWithURL:[NSURL URLWithString:[KSUserInfoModel sharedConstant].imgUrl] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }
    
    if(!lab_userName)
    {
        lab_userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 15, CGRectGetMinY(headImageView.frame) +5, 150, 20)];
        lab_userName.font = [UIFont systemFontOfSize:18];
        [_userInfoView addSubview:lab_userName];
    }
    NSLog(@"%@",[KSUserInfoModel sharedConstant].userName);
    NSLog(@"%@",[KSUserInfoModel sharedConstant].sex);

    if([[KSUserInfoModel sharedConstant].userName length] == 0)
    {
        lab_userName.text = [KSUserInfoModel sharedConstant].phone;
        
    }else
    {
        lab_userName.text = [KSUserInfoModel sharedConstant].userName?:[KSUserInfoModel sharedConstant].phone;
    }
    
    if(!sexImageView)
    {
        sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 15, CGRectGetMaxY(headImageView.frame) - 25, 20, 20)];
        [_userInfoView addSubview:sexImageView];
    }
    if([[KSUserInfoModel sharedConstant].sex length] == 0)
    {
        sexImageView.image = [UIImage imageNamed:@"sex_man"];
        
    }else if ([[KSUserInfoModel sharedConstant].sex isEqualToString:@"0"])
    {
        sexImageView.image = [UIImage imageNamed:@"sex_wuman"];

    }else
    {
        sexImageView.image = [UIImage imageNamed:@"sex_man"];
    }
    
    UIButton *btn_edit = [[UIButton alloc]initWithFrame:CGRectMake(SELFWIDTH - 60, CGRectGetMinY(headImageView.frame) +5, 25, 25)];
    [btn_edit setTitle:@"" forState:UIControlStateNormal];
    [btn_edit addTarget:self action:@selector(gotoEdit) forControlEvents:UIControlEventTouchUpInside];
    [btn_edit setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [_userInfoView addSubview:btn_edit];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark - 登陆相关 检查是否登陆

-(BOOL)checkLogin{
    BOOL isLogin = [KSAuthenticationCenter isLogin];
    if (!isLogin) {
        [self doLogin];
    }
    return isLogin;
}

-(void)doLogin{
    WEAKSELF
    void(^cancelActionBlock)(void) = ^(void){
        STRONGSELF
//        [WeAppToast toast:@"取消登陆"];
        // 如果当前选中的tab就是我的登陆页面，取消登陆后跳转到上次选中的tab
        if (strongSelf == strongSelf.rdv_tabBarController.selectedViewController) {
            if (strongSelf.rdv_tabBarController.preSelectedIndex != strongSelf.rdv_tabBarController.selectedIndex) {
                [strongSelf.rdv_tabBarController setSelectedIndex:strongSelf.rdv_tabBarController.preSelectedIndex];
            }else{
                [strongSelf.rdv_tabBarController setSelectedIndex:0];
            }
        }
    };
    
    void(^loginActionBlock)(BOOL loginSuccess) = ^(BOOL loginSuccess){
        STRONGSELF
        // 如果登陆成功就跳转到当前
        [strongSelf.rdv_tabBarController setSelectedViewController:strongSelf];
    };
    
    [[KSAuthenticationCenter sharedCenter] authenticateWithLoginActionBlock:loginActionBlock cancelActionBlock:cancelActionBlock];
}

- (void)gotoLogin:(id)sender
{
    ManWuLoginViewController *loginVC = [[ManWuLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)gotoRegister:(id)sender
{
    
    ManWuRegisterViewController *registerVC = [[ManWuRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)gotoEdit
{
    ManWuPersonInfoViewController *personInfoVC = [[ManWuPersonInfoViewController alloc]init];
    [self.navigationController pushViewController:personInfoVC animated:YES];
}

- (void)gotoConfig
{
    ManWuConfigViewController *configVC = [[ManWuConfigViewController alloc]init];
    [self.navigationController pushViewController:configVC animated:YES];
}

#pragma mark - 订单选项回调

- (void)didSelectedItem:(NSInteger)tag
{
    NSLog(@"%ld",(long)tag);
    ManWuMyOrdersViewController *myOrdersVC = [[ManWuMyOrdersViewController alloc]init];
    myOrdersVC.origIndex = tag + 1;
    [self.navigationController pushViewController:myOrdersVC animated:YES];

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
        forPayNum = 0; forSendNum = 0; forReceiveNum = 0; receivedNum = 0; forChangeNum = 0;
        NSArray *ordersList = (NSArray*)service.requestModel.dataList;
        for(KSOrderModel *orderModel in ordersList)
        {
            switch ([orderModel.status integerValue]) {
                case 1:
                    forPayNum ++;
                    break;
                case 2:
                    forSendNum ++;
                    break;
                case 3:
                    forReceiveNum ++;
                    break;
                case 4:
                    receivedNum ++;
                    break;
                case 5:
                    forChangeNum ++;
                    break;

                default:
                    break;
            }
        }
        
        forPayItem.remindNum = forPayNum;
        forSendItem.remindNum = forSendNum;
        forReceiveItem.remindNum = forReceiveNum;
//        receivedItem.remindNum = receivedNum;
        forChangeItem.remindNum = forChangeNum;
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
    return [dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataSource objectAtIndex:section]count];
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
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            return _userInfoView.height;
            
        }
    }else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            return _myInfoContainer.height;
        }
    }
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
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _userInfoView.height - 1, self.view.width, 1)];
            lineView.opaque = YES;
            lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
            [cell.contentView addSubview:_userInfoView];
            [cell.contentView addSubview:lineView];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
    }else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _myInfoContainer.height - 1, self.view.width, 1)];
            lineView.opaque = YES;
            lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
            [cell.contentView addSubview:_myInfoContainer];
            [cell.contentView addSubview:lineView];
            return cell;
        }

    }
    
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            if(indexPath.row == 0)
            {
                
            }
            else
            {
                ManWuMyOrdersViewController *myOrdersVC = [[ManWuMyOrdersViewController alloc]init];
                myOrdersVC.origIndex = 0;
                [self.navigationController pushViewController:myOrdersVC animated:YES];
            }
 
        }
            break;
        case 2:
        {
            if(indexPath.row == 0)
            {
                TBOpenURLFromTargetWithNativeParams(kManWuAddressManager, self, nil, nil);
                
            }else if (indexPath.row == 1)
            {
                TBOpenURLFromTargetWithNativeParams(internalURL(KManWuCommodityListFavorite), self,nil,nil);
                
            }else if (indexPath.row == 2)
            {
                ManWuMyRedPacketViewController *redPacketVC = [[ManWuMyRedPacketViewController alloc]init];
                [self.navigationController pushViewController:redPacketVC animated:YES];
                
            }else if (indexPath.row == 3)
            {
                ManWuMyInviteCodeViewController *inviteCodeVC = [[ManWuMyInviteCodeViewController alloc]init];
                [self.navigationController pushViewController:inviteCodeVC animated:YES];
                
            }else
            {
                
            }
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark- KSTabBarViewControllerProtocol

-(BOOL)shouldSelectViewController:(UIViewController *)viewController{
    return [self checkLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
