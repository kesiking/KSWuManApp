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

@interface ManWuHomeViewController ()

@property (nonatomic, strong) ManWuHomeHeaderView            *headerView;

@property (nonatomic,strong) ManWuCommodityListView          *commodityListView;


@end

@implementation ManWuHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"屋满";
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeContactAdd];
////    button.frame = CGRectMake(0, 0, 100, 100);
//    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    [self.view addSubview:self.commodityListView];
    [self.headerView setDescriptionModel:nil];
    [self.headerView sizeToFit];
    [self.commodityListView.collectionViewCtl setColletionHeaderView:self.headerView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)add{
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:@"commodityId",@"commodityId", nil];
    TBOpenURLFromTargetWithNativeParams(internalURL(kManWuCommodityList), self,nil,params);
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
    }
    return _commodityListView;
}

@end
