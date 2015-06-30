//
//  ManWuOrderDetailViewController.m
//  basicFoundation
//
//  Created by 许学 on 15/6/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuOrderDetailViewController.h"
#import "KSOrderDetailView.h"

@interface ManWuOrderDetailViewController ()<KSOrderDetailViewDelegate>
{
    KSOrderDetailView *orderDetailView;
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
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service == _service) {
        // todo fail
        NSString *errorInfo = error.userInfo[@"NSLocalizedDescription"];
        [WeAppToast toast:errorInfo];
        
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
