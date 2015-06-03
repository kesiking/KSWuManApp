//
//  ManWuCommdityFavoriteListViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommdityFavoriteListViewController.h"
#import "ManWuCommodityListForDeleteView.h"
#import "ManWuCommodityFavListService.h"

@interface ManWuCommdityFavoriteListViewController ()

@property (nonatomic,strong) ManWuCommodityListForDeleteView* commodityListView;

@property (nonatomic,strong) UIBarButtonItem* editListButtonItem;
@property (nonatomic,strong) UIBarButtonItem* finishListButtonItem;

@property (nonatomic,strong) ManWuCommodityFavListService    *favListService;

@end

@implementation ManWuCommdityFavoriteListViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {

    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我收藏的";
    [self.view addSubview:self.commodityListView];
    self.editListButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editStart:)];
    self.finishListButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(editFinish:)];
    self.navigationItem.rightBarButtonItem = self.editListButtonItem;
    
    [self.favListService loadCommodityFavorateData];
}

-(void)viewDidUnload{
    self.commodityListView = nil;
    [super viewDidUnload];
}

- (void)editStart:(UIBarButtonItem*)button{
    [self.commodityListView setIsCollectionEdit:!self.commodityListView.isCollectionEdit];
    self.navigationItem.rightBarButtonItem = self.finishListButtonItem;
}

- (void)editFinish:(UIBarButtonItem*)button{
    [self.commodityListView setIsCollectionEdit:!self.commodityListView.isCollectionEdit];
    self.navigationItem.rightBarButtonItem = self.editListButtonItem;
}

-(ManWuCommodityListForDeleteView *)commodityListView{
    if (_commodityListView == nil) {
        _commodityListView = [[ManWuCommodityListForDeleteView alloc] initWithFrame:self.view.bounds];
        [_commodityListView setCollectionService:self.favListService];
    }
    return _commodityListView;
}

-(ManWuCommodityFavListService *)favListService{
    if (_favListService == nil) {
        _favListService = [[ManWuCommodityFavListService alloc] init];
    }
    return _favListService;
}

-(void)refreshDataRequest{
    [self.favListService loadCommodityFavorateData];
}

@end
