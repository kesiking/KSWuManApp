//
//  ManWuDiscoverViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverViewController.h"
#import "ManWuDiscoverListView.h"
#import "ManWuDiscoverService.h"

@interface ManWuDiscoverViewController ()<WeAppBasicServiceDelegate>

@property (nonatomic ,strong) ManWuDiscoverListView*         discoverListView;

@property (nonatomic ,strong) ManWuDiscoverService*          discoverService;

@end

@implementation ManWuDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.discoverListView];
    [self.discoverService loadAllCategoryCommodityListData];
    [self showLoadingView];
}

-(void)viewDidUnload{
    self.discoverListView = nil;
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发现";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuDiscoverListView *)discoverListView{
    if (_discoverListView == nil) {
        _discoverListView = [[ManWuDiscoverListView alloc] initWithFrame:self.view.bounds];
        WEAKSELF
        [_discoverListView.tableViewCtl setOnRefreshEvent:^(KSScrollViewServiceController* scrollViewController){
            STRONGSELF
            [strongSelf.discoverService loadAllCategoryCommodityListData];
        }];
    }
    return _discoverListView;
}

-(ManWuDiscoverService *)discoverService{
    if (_discoverService == nil) {
        _discoverService = [[ManWuDiscoverService alloc] init];
        _discoverService.delegate = self;
    }
    return _discoverService;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service{
    
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service{
    [self hideLoadingView];
    if (service && [service.dataList count] > 0) {
        [self.discoverListView setDataWithPageList:service.dataList extraDataSource:nil];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    if (service.dataList == nil && service.cacheComponentItems && [service.cacheComponentItems count] > 0) {
        [self.discoverListView setDataWithPageList:service.cacheComponentItems extraDataSource:nil];
    }
    [self hideLoadingView];
}

-(void)serviceCacheDidLoad:(WeAppBasicService *)service cacheData:(NSArray *)cacheData{
    if (self.discoverListView.tableViewCtl.configObject.scrollViewCacheType == KSScrollViewConfigCacheType_default) {
        if (cacheData && [cacheData count] > 0) {
            [self.discoverListView setDataWithPageList:cacheData extraDataSource:nil];
        }
    }
}

@end
