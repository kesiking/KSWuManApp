//
//  ManWuOrderDetailViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuOrderDetailViewController.h"
#import "KSOrderDetailView.h"
#import "ManWuPostSaleServiceViewController.h"

@interface ManWuOrderDetailViewController ()<KSOrderDetailViewDelegate,UIAlertViewDelegate>
{
    KSOrderDetailView *orderDetailView;
    UIAlertView *myAlertView;
}

@end

@implementation ManWuOrderDetailViewController

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
    
    self.title = @"订单详情";
    
    orderDetailView = [[KSOrderDetailView alloc]initWithFrame:self.view.frame OrderModel:self.orderModel];
    orderDetailView.delegate = self;
    [self.view addSubview:orderDetailView];
}

#pragma mark - KSOrderDetailViewDelegate method
- (void)didSelectedButtonStyle:(ButtonSelectedStyle)style
{
    switch (style) {
        case ButtonSelectedStyleCancelOrder:
        {
            myAlertView = [[UIAlertView alloc]initWithTitle:@"是否取消订单？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            myAlertView.tag = 7;
            [myAlertView show];
        }
            break;
        case ButtonSelectedStyleDeleteOrder:
        {
            
        }
            break;
        case ButtonSelectedStylePay:
        {
            
        }
            break;
        case ButtonSelectedStyleNoteSend:
        {
            
        }
            break;
        case ButtonSelectedStyleReceived:
        {
            
        }
            break;
        case ButtonSelectedStyleService:
        {
            ManWuPostSaleServiceViewController *postsaleService = [[ManWuPostSaleServiceViewController alloc]init];
            postsaleService.orderModel = self.orderModel;
            [self.navigationController pushViewController:postsaleService animated:YES];
        }
            break;

            
        default:
            break;
    }
}

#pragma mark - WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service
{
    if (service == _service) {
        // todo success
        if([service.requestModel.apiName isEqualToString:@"order/modifyOrder.do"])
        {
            return;
        }

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
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
        
    }
}

#pragma mark - alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger toStatus = alertView.tag;
    
    if(buttonIndex == 0)
    {
        return;
        
    }else
    {
        switch (toStatus) {
            case 7:
            {
                //取消订单操作
                [self.service loadItemWithAPIName:@"order/modifyOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"orderId":_orderModel.orderId,@"status":@7} version:nil];
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
