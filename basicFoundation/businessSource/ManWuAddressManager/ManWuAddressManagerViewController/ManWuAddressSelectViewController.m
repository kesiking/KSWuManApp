//
//  ManWuAddressManagerViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressSelectViewController.h"
#import "ManWuAddressSelectListView.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"

@interface ManWuAddressSelectViewController ()

@property (nonatomic,strong) ManWuAddressSelectListView* commodityListView;

@property (nonatomic,strong) successWrapper              successBlock;

@property (nonatomic,strong) failureWrapper              failureWrapper;

@property (nonatomic,assign) BOOL                        needRefreshList;

@end

@implementation ManWuAddressSelectViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        if (nativeParams) {
            self.successBlock = [nativeParams objectForKey:kAddressSelectedSuccessBlock];
            self.failureWrapper = [nativeParams objectForKey:kAddressSelectedFailureBlock];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStyleBordered target:self action:@selector(managerAddress)];
    [self.view addSubview:self.commodityListView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 刷新逻辑，更新了收货管理列表后需要刷新
    if (self.needRefreshList) {
        // 刷新list
        [self.commodityListView refreshDataRequest];
        self.needRefreshList = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)managerAddress{
    // 跳转到管理地址页面
    // 如果有数据更新需要重新请求数据刷新
    WEAKSELF
    addressDidChangeBlock addressDidChangeBlock = ^(BOOL addressDidChange,WeAppComponentBaseItem *addressModel) {
        STRONGSELF
        if (addressDidChange) {
            // todo refresh
            strongSelf.needRefreshList = addressDidChange;
        }
    };
    NSDictionary *callBacks =[NSDictionary dictionaryWithObjectsAndKeys:addressDidChangeBlock, kAddressManagerSuccessBlock, nil];
    TBOpenURLFromTargetWithNativeParams(kManWuAddressManager, self, nil, callBacks);
}

-(ManWuAddressSelectListView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuAddressSelectListView alloc] initWithFrame:self.view.bounds];
        WEAKSELF
        _commodityListView.addressSelectBlock = ^(ManWuAddressInfoModel* addressComponentItem){
            STRONGSELF
            if (strongSelf.successBlock) {
                strongSelf.successBlock(addressComponentItem);
            }
        };
    }
    return _commodityListView;
}

@end
