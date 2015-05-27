//
//  ManWuCommodityListForDiscountViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListForDiscountViewController.h"
#import "ManWuCommodityListSortAndFiltForDiscountView.h"

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

-(void)viewDidUnload{
    self.commodityListView = nil;
    [super viewDidUnload];
}

-(ManWuCommodityListSortAndFiltForDiscountView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListSortAndFiltForDiscountView alloc] initWithFrame:self.view.bounds];
        [_commodityListView setDescriptionModel:self.activityModel];
        [_commodityListView loadDataWithParams:@{@"actIdKey":self.actId?:defaultActIdKey,@"filtKey":self.cid?:defaultCidKey,@"sortKey":defaultSortKey}];
    }
    return _commodityListView;
}

@end
