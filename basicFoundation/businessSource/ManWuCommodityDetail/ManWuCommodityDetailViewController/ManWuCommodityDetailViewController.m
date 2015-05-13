//
//  ManWuCommodityDetailViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDetailViewController.h"
#import "ManWuDetailSKUView.h"
#import "ManWuCommodityDetailModel.h"
#import "ManWuCommodityDetailService.h"
#import "ManWuCommodityView.h"

#define TBDETAIL_SKU_HEIGHT                320            //SKU的高度

@interface ManWuCommodityDetailViewController ()<KSDetailTradeSKUViewDelegate,WeAppBasicServiceDelegate>

@property (nonatomic, strong) ManWuDetailSKUView           *skuView;

@property (nonatomic, strong) ManWuCommodityView           *commodityDetailView;

@property (nonatomic, strong) UIButton                     *confirmButton;

@property (nonatomic, strong) ManWuCommodityDetailModel    *detailModel;

@property (nonatomic, strong) ManWuCommodityDetailService  *service;

@end

@implementation ManWuCommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.commodityDetailView];
    [self.view addSubview:self.confirmButton];
    
    NSDictionary* dict = @{@"skuTitle":@"titleTest",@"skuDetailModel":@{@"skuModel":@{@"skuTitle":@"skuTitleTest1",@"skus":@{@"quantity":@2},@"skuProps":@[@{@"propName":@"propNameTest",@"values":@[@{@"name":@"nameTest"},@{@"name":@"nameTest1"}]},@{@"propName":@"propNameTest",@"values":@[@{@"name":@"nameTest"},@{@"name":@"nameTest1"}]},@{@"propName":@"propNameTest2",@"values":@[@{@"name":@"nameTest2"},@{@"name":@"nameTest3"}]}]}}};
    self.detailModel = [ManWuCommodityDetailModel modelWithJSON:dict];
    [self.service loadInvite];
    [self.commodityDetailView setDescriptionModel:self.detailModel];
    [self reloadData];
}

-(void)dealloc{
    _skuView.delegate = nil;
    _skuView = nil;
    _service.delegate = nil;
    _service = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuCommodityDetailService *)service{
    if (_service == nil) {
        _service = [[ManWuCommodityDetailService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(ManWuCommodityView *)commodityDetailView{
    if (_commodityDetailView == nil) {
        _commodityDetailView = [[ManWuCommodityView alloc] initWithFrame:self.view.bounds];
    }
    return _commodityDetailView;
}

-(UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
        [_confirmButton setTitle:@"选购" forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:RGB_A(0x00, 0x00, 0x00, 0.5)];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (ManWuDetailSKUView *)skuView{
    if (!_skuView) {
        CGRect frame = CGRectMake(0, 0, [TBDetailSystemUtil getCurrentDeviceWidth], TBDETAIL_SKU_HEIGHT);
        _skuView = [[ManWuDetailSKUView alloc] initWithFrame:frame];
        _skuView.delegate = self;
    }
    return _skuView;
}

-(void)confirmButtonClicked:(id)sender{
    [self presentSemiView:self.skuView withOptions:nil completion:nil];
}

-(void)reloadData{
    self.skuView.skuDetailModel = self.detailModel.skuDetailModel;
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    [WeAppToast toast:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
}


/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - KSDetailTradeSKUViewDelegate

- (void)tradeSkuView:(ManWuDetailSKUView *)skuView dismissSkuViewHandleBlock:(dispatch_block_t)block {
    [self dismissSemiModalViewWithCompletion:^{
        !block ?: block();
    }];
}

- (void)tradeSkuValueDidChange:(ManWuDetailSKUView *)skuView {
    
}

@end
