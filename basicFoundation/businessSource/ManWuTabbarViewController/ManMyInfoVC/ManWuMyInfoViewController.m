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

@implementation ManWuMyInfoViewController
{
    NSArray *dataSource;
    BOOL isAlreadyLogined;
}

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

    self.title = @"我的";
    dataSource = @[@[@"CSLineLayout"],@[@"CSLineLayout",@"全部订单"],@[@"常用收货地址",@"我收藏的",@"我的红包",@"我的邀请码"]];
    
    
    [self initCSLineLayoutView];
    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(_userInfoView)
    {
        [_userInfoView removeFromSuperview];
    }
    
    [self initUserInfoView];
    
    [self.table reloadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    _btn_config = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_config.frame = CGRectMake(SELFWIDTH - 48, 0, 44, 44);
    _btn_config.layer.cornerRadius = 2;
    _btn_config.titleLabel.font = [UIFont systemFontOfSize:15.5f];
    _btn_config.clipsToBounds = YES;
    _btn_config.userInteractionEnabled = YES;
    [_btn_config setTitle:@"设置" forState:UIControlStateNormal];
    [_btn_config setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

- (void)initCSLineLayoutView
{
    _myInfoContainer = [[CSLinearLayoutView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    _myInfoContainer.orientation = CSLinearLayoutViewOrientationHorizontal;
    _myInfoContainer.scrollEnabled = YES;
    CGFloat padding = (self.view.width / 5.0 - 40)/2;
    // add ten views
    for (int i=0; i<5; i++) {
        UserInfoViewItem *useritem = [[UserInfoViewItem alloc]initWithFrame:CGRectMake(0.0, 0.0, 40.0, 60.0) Tag:i];
        useritem.delegate = self;
        useritem.itemImageView.image = [UIImage imageNamed:@"tabitem_home_highlight"];
        useritem.itemName.text = @"代收货";
        CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:useritem];
        item.padding = CSLinearLayoutMakePadding(10.0, padding,10.0, padding);
        item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
        item.verticalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
        [_myInfoContainer addItem:item];
    }
}

- (void)initUserInfoView
{
    if([KSUserInfoModel sharedConstant].isLogined)
    {
        _userInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
        //_userInfoView.backgroundColor = [UIColor clearColor];
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, _userInfoView.height/2 - 30, 60, 60)];
        headImageView.layer.cornerRadius = 30;
        //headImageView.layer.borderWidth = 1;
        NSURL *url = [NSURL URLWithString:[KSUserInfoModel sharedConstant].imgUrl];
        [headImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"tabitem_home_highlight"]];
        [_userInfoView addSubview:headImageView];
        
        UILabel *lab_userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 15, CGRectGetMinY(headImageView.frame) +5, 150, 20)];
        lab_userName.font = [UIFont systemFontOfSize:18];
        lab_userName.text = @"USER NAME";
        [_userInfoView addSubview:lab_userName];
        
        UIButton *btn_edit = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 15, CGRectGetMaxY(headImageView.frame) - 25, 20, 20)];
        [btn_edit setTitle:@"" forState:UIControlStateNormal];
        [btn_edit addTarget:self action:@selector(gotoEdit) forControlEvents:UIControlEventTouchUpInside];
        btn_edit.backgroundColor = [UIColor grayColor];
        [_userInfoView addSubview:btn_edit];

        return;
    }
    _userInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    //_userInfoView.backgroundColor = [UIColor clearColor];
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_userInfoView.width/2 - 30, _userInfoView.height/2 - 30, 60, 60)];
    headImageView.layer.cornerRadius = 30;
    //headImageView.layer.borderWidth = 1;
    headImageView.backgroundColor = [UIColor grayColor];
    [_userInfoView addSubview:headImageView];
    
    UIButton *btn_login = [[UIButton alloc]initWithFrame:CGRectMake(_userInfoView.width/2 - headImageView.width/2 - 30 - 60, _userInfoView.height/2 - 15, 60, 30)];
    [btn_login setTitle:@"登录" forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];
    btn_login.backgroundColor = [UIColor grayColor];
    [_userInfoView addSubview:btn_login];
    
    UIButton *btn_register = [[UIButton alloc]initWithFrame:CGRectMake(_userInfoView.width/2 + headImageView.width/2 + 30, _userInfoView.height/2 - 15, 60, 30)];
    [btn_register setTitle:@"注册" forState:UIControlStateNormal];
    [btn_register addTarget:self action:@selector(gotoRegister:) forControlEvents:UIControlEventTouchUpInside];
    btn_register.backgroundColor = [UIColor grayColor];
    [_userInfoView addSubview:btn_register];
    
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

- (void)didSelectedItem:(NSInteger)tag
{
    NSLog(@"%ld",(long)tag);
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
                
            }else if (indexPath.row == 3)
            {
                
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
    BOOL isLogin = [KSUserInfoModel sharedConstant].isLogined;
    if (!isLogin) {
        WEAKSELF
        void(^cancelActionBlock)(void) = ^(void){
            [WeAppToast toast:@"取消登陆"];
        };
        
        void(^loginActionBlock)(BOOL loginSuccess) = ^(BOOL loginSuccess){
            STRONGSELF
            // 如果登陆成功就跳转到当前
            [strongSelf.rdv_tabBarController setSelectedViewController:strongSelf];
        };
        
        NSDictionary *callBacks =[NSDictionary dictionaryWithObjectsAndKeys:loginActionBlock, kLoginSuccessBlock,cancelActionBlock, kLoginCancelBlock, nil];
        
        TBOpenURLFromTargetWithNativeParams(loginURL, self, nil, callBacks);
    }
    return isLogin;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
