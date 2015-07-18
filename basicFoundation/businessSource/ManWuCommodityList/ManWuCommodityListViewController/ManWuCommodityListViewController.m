//
//  ManWuCommodityListViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListViewController.h"
#import "ManWuCommodityListWithSortAndFiltBasicView.h"
#import "ManWuPraiseService.h"

@interface ManWuCommodityListViewController()

@property (nonatomic,strong) ManWuCommodityListWithSortAndFiltView* commodityListView;

@property (nonatomic,strong) NSString* actId;

@property (nonatomic,strong) NSString* cid;

@end

@implementation ManWuCommodityListViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        self.actId = [nativeParams objectForKey:@"actId"];
        self.cid = [nativeParams objectForKey:@"cid"];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"商品列表";
    [self.view addSubview:self.commodityListView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidUnload{
    self.commodityListView = nil;
    [super viewDidUnload];
}

-(ManWuCommodityListWithSortAndFiltView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListWithSortAndFiltView alloc] initWithFrame:self.view.bounds];
        [_commodityListView loadDataWithParams:@{@"actIdKey":self.actId?:defaultActIdKey,@"filtKey":self.cid?:defaultCidKey,@"sortKey":defaultSortKey}];
    }
    return _commodityListView;
}

-(void)refreshDataRequest{
    [self.commodityListView refreshDataRequest];
//    [self.commodityListView loadDataWithParams:@{@"actIdKey":self.actId?:defaultActIdKey,@"filtKey":self.cid?:defaultCidKey,@"sortKey":defaultSortKey}];
}

@end
