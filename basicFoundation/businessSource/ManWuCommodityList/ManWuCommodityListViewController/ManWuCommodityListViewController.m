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

@property (nonatomic,assign) BOOL      shouldRefreshView;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPraiseNotification:) name:kUserAddPraiseSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unAddPraiseNotification:) name:kUserUnAddPraiseSuccessNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.shouldRefreshView) {
        self.shouldRefreshView = NO;
        [self.commodityListView refreshDataRequest];
    }
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
    [self.commodityListView loadDataWithParams:@{@"actIdKey":self.actId?:defaultActIdKey,@"filtKey":self.cid?:defaultCidKey,@"sortKey":defaultSortKey}];
}

-(void)addPraiseNotification:(NSNotification*)notification{
    if (!self.isViewAppear) {
        NSDictionary* userInfo = notification.userInfo;
        if (userInfo) {
            NSString* itemId = [userInfo objectForKey:@"itemId"];
            NSLog(@"itemId: %@",itemId);
        }
        self.shouldRefreshView = YES;
    }
}

-(void)unAddPraiseNotification:(NSNotification*)notification{
    if (!self.isViewAppear) {
        self.shouldRefreshView = YES;
    }
}

@end
