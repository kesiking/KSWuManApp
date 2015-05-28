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

@property (nonatomic, strong) NSString                     *itemId;

@property (nonatomic, strong) ManWuDetailSKUView           *skuView;

@property (nonatomic, strong) ManWuCommodityView           *commodityDetailView;

@property (nonatomic, strong) UIButton                     *confirmButton;

@property (nonatomic, strong) ManWuCommodityDetailModel    *detailModel;

@property (nonatomic, strong) ManWuCommodityDetailService  *service;

@end

@implementation ManWuCommodityDetailViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        self.itemId = [nativeParams objectForKey:@"itemId"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品详情";
    [self.view addSubview:self.commodityDetailView];
    [self.view addSubview:self.confirmButton];
    [self.service loadCommodityDetailInfoWithItemId:self.itemId];
    /*
     NSDictionary* dict = @{@"skuTitle":@"titleTest",@"skuDetailModel":@{@"skuModel":@{@"skuTitle":@"skuTitleTest1",@"skus":@{@"quantity":@2},@"skuProps":@[@{@"propName":@"propNameTest",@"values":@[@{@"name":@"nameTest"},@{@"name":@"nameTest1"}]},@{@"propName":@"propNameTest",@"values":@[@{@"name":@"nameTest"},@{@"name":@"nameTest1"}]},@{@"propName":@"propNameTest2",@"values":@[@{@"name":@"nameTest2"},@{@"name":@"nameTest3"}]}]}}};
     self.detailModel = [ManWuCommodityDetailModel modelWithJSON:dict];
     [self.commodityDetailView setDescriptionModel:self.detailModel];
     [self reloadData];
     */
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
        WEAKSELF
        _service.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            if (service && service.item && [service.item isKindOfClass:[ManWuCommodityDetailModel class]]) {
                strongSelf.detailModel = (ManWuCommodityDetailModel*)service.item;
                [strongSelf.commodityDetailView setDescriptionModel:strongSelf.detailModel];
                [strongSelf reloadData];
            }
            
        };
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
        WEAKSELF
        _skuView.gotoBuyBlock = ^(ManWuDetailSKUView* skuView, NSDictionary* params){
            STRONGSELF
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            if (params) {
                [dict setObject:params forKey:@"skuDict"];
            }
            if (strongSelf.detailModel) {
                [dict setObject:strongSelf.detailModel forKey:@"detailModel"];
            }
            [strongSelf gotoBuyPageWithParams:dict];
        };
        _skuView.delegate = self;
    }
    return _skuView;
}

-(void)confirmButtonClicked:(id)sender{
    if ([self.detailModel.skuService hasSKU]) {
        [self presentSemiView:self.skuView withOptions:nil completion:nil];
    }else{
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        if (self.detailModel) {
            [dict setObject:self.detailModel forKey:@"detailModel"];
        }
        [self gotoBuyPageWithParams:dict];
    }
}

-(void)gotoBuyPageWithParams:(NSDictionary* )params{
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityBuyInfo), self,nil,params);
}

-(void)reloadData{
    self.skuView.detailModel = self.detailModel;
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
