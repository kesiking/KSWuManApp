//
//  ManWuHomeViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeViewController.h"
#import "ManWuHomeHeaderView.h"
#import "ManWuCommodityListView.h"
#import "ManWuCommodityNewListService.h"

@interface ManWuHomeViewController (){
    
}

@property (nonatomic, strong) ManWuHomeHeaderView          *headerView;

@property (nonatomic, strong) ManWuCommodityListView       *commodityListView;

@property (nonatomic, strong) ManWuCommodityNewListService *newListService;


@end

@implementation ManWuHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"屋满";
    [self.view addSubview:self.commodityListView];
    [self.headerView setDescriptionModel:nil];
    [self.headerView sizeToFit];
    [self.commodityListView.collectionViewCtl setColletionHeaderView:self.headerView];
    [self.newListService loadCommodityListData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - discountInfo

-(ManWuHomeHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[ManWuHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.commodityListView.collectionViewCtl.frame.size.width, 0)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

#pragma mark - commodityListView

-(ManWuCommodityListView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListView alloc] initWithFrame:self.view.bounds];
        _commodityListView.backgroundColor = [UIColor whiteColor];
        __weak __block __typeof(self) weadSelf = self;
        _commodityListView.collectionViewCtl.onRefreshEvent = ^(KSScrollViewServiceController* scrollViewController){
            if (weadSelf == nil) {
                return;
            }
            __strong __typeof(self) strongSelf = weadSelf;
            [strongSelf.headerView refresh];
        };
        [_commodityListView setCollectionService:self.newListService];
    }
    return _commodityListView;
}

-(ManWuCommodityNewListService *)newListService{
    if (_newListService == nil) {
        _newListService = [[ManWuCommodityNewListService alloc] init];
    }
    return _newListService;
}

@end
