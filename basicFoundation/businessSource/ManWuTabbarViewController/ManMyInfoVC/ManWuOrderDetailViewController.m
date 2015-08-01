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
#import "KSSafePayUtility.h"

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
            myAlertView = [[UIAlertView alloc]initWithTitle:@"是否删除订单？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            myAlertView.tag = 8;
            [myAlertView show];

        }
            break;
        case ButtonSelectedStylePay:
        {
            
            NSDictionary* params = @{@"tradeNO":self.orderModel.orderId?:@"",@"productName":self.orderModel.title?:@"",@"productDescription":self.orderModel.title?:@"",@"price":[NSString stringWithFormat:@"%@",self.orderModel.payPrice?:@0.01]};
            
            [KSSafePayUtility aliPayForParams:params callbackBlock:^(NSDictionary *resultDic) {
                // 支付成功后 todo

                BOOL ret = (BOOL)resultDic[@"isSuccess"];
                if(ret)
                {
                    NSLog(@"++++++++++++++支付成功");
                    self.orderModel.status = [NSString stringWithFormat:@"%d",2];
                    [orderDetailView updateViewWithOrderModel:self.orderModel];
                }else
                {
                    NSLog(@"++++++++++++++支付失败");
                }
            }];
        }
            break;
        case ButtonSelectedStyleNoteSend:
        {
            
        }
            break;
        case ButtonSelectedStyleReceived:
        {
            [self.service loadItemWithAPIName:@"order/modifyOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"orderId":self.orderModel.orderId,@"status":@4} version:nil];
        }
            break;
        case ButtonSelectedStyleService:
        {
            ManWuPostSaleServiceViewController *postsaleService = [[ManWuPostSaleServiceViewController alloc]init];
            postsaleService.orderModel = self.orderModel;
            postsaleService.postSaleServeSuccess = ^(BOOL ret)
            {
                self.orderModel.status = [NSString stringWithFormat:@"%d",5];
                [orderDetailView updateViewWithOrderModel:self.orderModel];
                
            };
            
            [self.navigationController pushViewController:postsaleService animated:YES];
        }
            break;

            
        default:
            break;
    }
}

- (void)didSelectedOrderInfoItem:(KSOrderModel *)orderModel
{
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:orderModel.itemId?:@"",@"itemId", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityDetail), self,nil,params);
}

#pragma mark - WeAppBasicServiceDelegate method

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
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:service.requestModel.params];
        if([service.requestModel.apiName isEqualToString:@"order/modifyOrder.do"])
        {
            if([[dic objectForKey:@"status"] integerValue] == 8)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                self.orderModel.status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                [orderDetailView updateViewWithOrderModel:self.orderModel];
            }
            return;
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
            case 8:
            {
                //取消订单操作
                [self.service loadItemWithAPIName:@"order/modifyOrder.do" params:@{@"userId":[KSUserInfoModel sharedConstant].userId,@"orderId":_orderModel.orderId,@"status":@8} version:nil];
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
