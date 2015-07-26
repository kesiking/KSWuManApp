//
//  ManWuConfigViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/5/20.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuConfigViewController.h"
#import "ManWuFeedBackViewController.h"
#import "ManWuAboutViewController.h"

#define DEFAULT_CELL_HEIGHT 44      //tableView默认行高

@interface ManWuConfigViewController ()<UIAlertViewDelegate>
{
    NSArray *dataArray;
    UIAlertView *myAlertView;
    NSString *appUrl;
}

@end

@implementation ManWuConfigViewController

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
    self.title = @"设置";
    
    dataArray = @[@[@"意见反馈",@"去App Store评分"],@[@"清除缓存",@"关于我们",@"版本更新"]];
    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self quitMethod];
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
        if([service.requestModel.apiName isEqualToString:@"app/getIos.do"])
        {
            NSDictionary *dataDic = [[NSDictionary alloc]initWithDictionary:(NSDictionary*)service.requestModel.item];
            NSString *buildNum = dataDic[@"version"];
            if([buildNum length] == 0 || [buildNum intValue] < [MYBUILDNUM intValue])
            {
                [WeAppToast toast:@"当前已是最新版本"];
                return;
            }
            if([buildNum intValue] > [MYBUILDNUM intValue])
            {
                appUrl = dataDic[@"url"];
                myAlertView = [[UIAlertView alloc]initWithTitle:@"新版本升级" message:nil delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"确定", nil];
                myAlertView.tag = 101;
                [myAlertView show];

            }

        }
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataArray objectAtIndex:section]count];
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
    
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
                ManWuFeedBackViewController *feedBackVC = [[ManWuFeedBackViewController    alloc]init];
                [self.navigationController pushViewController:feedBackVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appUrl]];
            }
        }
            break;
        case 1:
        {
            if(indexPath.row == 0)
            {
                myAlertView = [[UIAlertView alloc]initWithTitle:@"是否清除缓存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                myAlertView.tag = 100;
                [myAlertView show];
            }
            else if (indexPath.row == 1)
            {
                ManWuAboutViewController *aboutView = [[ManWuAboutViewController alloc]init];
                [self.navigationController pushViewController:aboutView animated:YES];
            }
            else if (indexPath.row == 2)
            {
                [self.service loadItemWithAPIName:@"app/getIos.do" params:nil version:nil];
            }
            
        }
            break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        return;
    }
    switch (alertView.tag) {
        case 100:
            [[SDImageCache sharedImageCache ] clearDisk];
            [[NSNotificationCenter defaultCenter]postNotificationName:ClearCacheNotification object:nil];
            [WeAppToast toast:@"清除缓存成功"];
            break;
        case 101:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appUrl]];
            break;

            
        default:
            break;
    }
}

- (void)quitMethod
{
    UIView *viewQuit = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SELFWIDTH, 60 + DEFAULT_CELL_HEIGHT)];
    [_table setTableFooterView:viewQuit];
    
    CGRect rectButton=CGRectMake(0,60, SELFWIDTH, DEFAULT_CELL_HEIGHT);
    UIButton * quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=rectButton;
    quitBtn.tag=2001;
    [quitBtn setBackgroundImage:[TBDetailUIStyle createImageWithColor:[TBDetailUIStyle   colorWithHexString:@"#ffffff"]] forState:UIControlStateNormal];
    quitBtn.layer.cornerRadius=3;
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewQuit addSubview:quitBtn];
}

-(void)quitButtonClick:(UIButton*)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[LOGIN_FLAG filePathOfCaches] error:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
