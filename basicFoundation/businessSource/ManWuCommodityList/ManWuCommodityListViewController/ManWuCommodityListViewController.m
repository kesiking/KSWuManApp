//
//  ManWuCommodityListViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListViewController.h"
#import "ManWuCommodityListWithSortAndFiltBasicView.h"

@interface ManWuCommodityListViewController()

@property (nonatomic,strong) ManWuCommodityListWithSortAndFiltView* commodityListView;

@end

@implementation ManWuCommodityListViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        NSString* commodityId = [nativeParams objectForKey:@"commodityId"];
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

-(ManWuCommodityListWithSortAndFiltView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListWithSortAndFiltView alloc] initWithFrame:self.view.bounds];
        [_commodityListView loadDataWithParams:@{@"filtKey":@"2",@"sortKey":@"2"}];
    }
    return _commodityListView;
}

@end
