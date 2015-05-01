//
//  ManWuCommodityListViewController.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListViewController.h"
#import "ManWuCommodityListView.h"

@interface ManWuCommodityListViewController()

@property (nonatomic,strong) ManWuCommodityListView* commodityListView;

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

-(ManWuCommodityListView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListView alloc] initWithFrame:self.view.bounds];
    }
    return _commodityListView;
}

@end
