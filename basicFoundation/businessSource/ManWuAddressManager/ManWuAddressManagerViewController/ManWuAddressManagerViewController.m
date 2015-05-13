//
//  ManWuAddressManagerViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressManagerViewController.h"
#import "ManWuAddressManagerListView.h"
#import "ManWuAddressInfoModel.h"
#import "ManWuAddressManagerMaroc.h"

@interface ManWuAddressManagerViewController ()

@property (nonatomic,strong) ManWuAddressManagerListView* commodityListView;

@property (nonatomic,strong) addressDidChangeBlock        addressDidChangeBlock;

@property (nonatomic,assign) BOOL                         needRefreshList;

@end

@implementation ManWuAddressManagerViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        if (nativeParams) {
            self.addressDidChangeBlock = [nativeParams objectForKey:kAddressManagerSuccessBlock];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"管理收货地址";
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

-(ManWuAddressManagerListView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuAddressManagerListView alloc] initWithFrame:self.view.bounds];
        WEAKSELF
        _commodityListView.addressDidChangeBlock = ^(BOOL addressDidChange, WeAppComponentBaseItem* addressComponentItem){
            STRONGSELF
            // 如果有数据更新需要重新请求数据刷新
            strongSelf.needRefreshList = addressDidChange;
            if (strongSelf.addressDidChangeBlock) {
                strongSelf.addressDidChangeBlock(addressDidChange,addressComponentItem);
            }
        };
    }
    return _commodityListView;
}

@end
