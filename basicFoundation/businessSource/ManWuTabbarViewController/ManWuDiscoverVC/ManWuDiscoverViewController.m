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
    self.title = @"发现";
    [self.view addSubview:self.discoverListView];
    [self.discoverService loadAllCategoryCommodityListData];
}

-(void)viewDidUnload{
    self.discoverListView = nil;
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ManWuDiscoverListView *)discoverListView{
    if (_discoverListView == nil) {
        _discoverListView = [[ManWuDiscoverListView alloc] initWithFrame:self.view.bounds];
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
    if (service && [service.dataList count] > 0) {
        [self.discoverListView setDataWithPageList:service.dataList extraDataSource:nil];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    
}

@end
