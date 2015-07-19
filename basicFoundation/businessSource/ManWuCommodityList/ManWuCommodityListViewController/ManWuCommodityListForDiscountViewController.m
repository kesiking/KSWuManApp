//
//  ManWuCommodityListForDiscountViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListForDiscountViewController.h"
#import "ManWuCommodityListSortAndFiltForDiscountView.h"
#import "ManWuPraiseService.h"

@interface ManWuCommodityListForDiscountViewController ()

@property (nonatomic,strong) ManWuCommodityListSortAndFiltForDiscountView* commodityListView;

@property (nonatomic,strong) NSString*                      actId;

@property (nonatomic,strong) NSString*                      cid;

@property (nonatomic,strong) WeAppComponentBaseItem*        activityModel;

@end

@implementation ManWuCommodityListForDiscountViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        self.actId = [nativeParams objectForKey:@"actId"];
        self.cid = [nativeParams objectForKey:@"cid"];
        self.activityModel = [nativeParams objectForKey:@"activityModel"];
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

-(ManWuCommodityListSortAndFiltForDiscountView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListSortAndFiltForDiscountView alloc] initWithFrame:self.view.bounds];
        if (self.actId) {
            [_commodityListView setActIdKey:self.actId];
        }else{
            [_commodityListView setDescriptionModel:self.activityModel];
        }
        NSMutableDictionary *params = [@{@"actIdKey":self.actId?:defaultActIdKey,@"sortKey":defaultSortKey} mutableCopy];
        if (self.cid) {
            [params setObject:self.cid forKey:@"filtKey"];
        }
        [_commodityListView loadDataWithParams:@{@"actIdKey":self.actId?:defaultActIdKey,@"filtKey":self.cid?:defaultCidKey,@"sortKey":defaultSortKey}];
    }
    return _commodityListView;
}

-(void)refreshDataRequest{
    [self.commodityListView refreshDataRequest];
//    [self.commodityListView loadDataWithParams:@{@"actIdKey":self.actId?:defaultActIdKey,@"filtKey":self.cid?:defaultCidKey,@"sortKey":defaultSortKey}];
}

@end
