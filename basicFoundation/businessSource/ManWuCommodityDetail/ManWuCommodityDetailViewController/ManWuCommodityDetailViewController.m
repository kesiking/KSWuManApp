//
//  ManWuCommodityDetailViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDetailViewController.h"
#import "TBDetailBigPhotoBrowerController.h"
#import "ManWuDetailSKUView.h"
#import "ManWuCommodityDetailModel.h"
#import "ManWuCommodityDetailService.h"

#define TBDETAIL_SKU_HEIGHT                320            //SKU的高度

@interface ManWuCommodityDetailViewController ()<KSDetailTradeSKUViewDelegate>

@property (nonatomic, strong) TBDetailBigPhotoBrowerController *simpleBrower;

@property (nonatomic, strong) ManWuDetailSKUView           *skuView;

@property (nonatomic, strong) ManWuCommodityDetailModel    *detailModel;

@property (nonatomic, strong) ManWuCommodityDetailService  *service;

@end

@implementation ManWuCommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    NSDictionary* dict = @{@"skuTitle":@"titleTest",@"skuDetailModel":@{@"skuModel":@{@"skuTitle":@"skuTitleTest1",@"skus":@{@"quantity":@2},@"skuProps":@[@{@"propName":@"propNameTest",@"values":@[@{@"name":@"nameTest"},@{@"name":@"nameTest1"}]},@{@"propName":@"propNameTest",@"values":@[@{@"name":@"nameTest"},@{@"name":@"nameTest1"}]},@{@"propName":@"propNameTest2",@"values":@[@{@"name":@"nameTest2"},@{@"name":@"nameTest3"}]}]}}};
    self.detailModel = [ManWuCommodityDetailModel modelWithJSON:dict];
    [self.service loadLogin];
    [self reloadData];
}

-(void)dealloc{
    [_simpleBrower removeFromSuperview];
    _simpleBrower = nil;
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
    }
    return _service;
}

-(TBDetailBigPhotoBrowerController *)simpleBrower{
    if (!_simpleBrower) {
        _simpleBrower = [[TBDetailBigPhotoBrowerController alloc] initWithFrame:self.view.bounds];
    }
    return _simpleBrower;
}

- (ManWuDetailSKUView *)skuView{
    if (!_skuView) {
        CGRect frame = CGRectMake(0, 0, [TBDetailSystemUtil getCurrentDeviceWidth], TBDETAIL_SKU_HEIGHT);
        _skuView = [[ManWuDetailSKUView alloc] initWithFrame:frame];
        _skuView.delegate = self;
    }
    return _skuView;
}

-(void)add{
    [self presentSemiView:self.skuView withOptions:nil completion:nil];
}

-(void)reloadData{
    self.skuView.skuDetailModel = self.detailModel.skuDetailModel;
}

/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - TBDetailBigPhotoBrowerController config

-(NSInteger)getCurrentChooseIndex
{
    NSInteger index = 0;
    
    for (TBDetailBigPhotoModel *model in self.simpleBrower.photoList) {
        if ([model.photoUrl isEqualToString:self.detailModel.skuDetailModel.skuService.currentSKUInfo.picUrl]) {
            index = [self.simpleBrower.photoList indexOfObject:model];
        }
    }
    
    return index;
}

-(void)configImgList:(NSInteger)index photoCount:(NSInteger)photoCount
{
    NSMutableArray *imgs = [[NSMutableArray alloc] initWithCapacity:photoCount];
    for (int i = 0; i < photoCount; i++) {
       
    }
    self.simpleBrower.imgs = imgs;
}

-(NSInteger)configBigPhotoBrowser
{
    [self.simpleBrower removeAllSubviews];
    
    /*配置photoList*/
    NSMutableArray *photoList = [NSMutableArray array];
    
    self.simpleBrower.photoList = (NSArray<TBDetailBigPhotoModel> *)photoList;
    
    NSInteger index = [self getCurrentChooseIndex];
    
    /*配置imgs*/
    [self configImgList:index photoCount:photoList.count];
    
    /*其他配置*/
    self.simpleBrower.selectedIndex = index;
    
    return index;
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
