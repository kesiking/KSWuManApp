//
//  ManWuCommoditySearchListViewController.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySearchListViewController.h"
#import "ManWuCommoditySearchListView.h"
#import <UIKit/UINavigationBar.h>
#import "ManWuSearchView.h"
#import "ManWuSearchViewCell.h"
#import "ManWuSearchViewCellInfoItem.h"

#define searchViewBorder (caculateNumber(22))

@interface ManWuCommoditySearchListViewController ()

@property (nonatomic,strong) NSString*                      searchKeyword;

@property (nonatomic,strong) ManWuCommoditySearchListView*  commodityListView;

@property (nonatomic,strong) UIView*                        searchNavigationView;

@property (nonatomic,strong) ManWuSearchView*               searchView;

@end

@implementation ManWuCommoditySearchListViewController

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query nativeParams:(NSDictionary *)nativeParams{
    if (self = [self init]) {
        self.searchKeyword = [nativeParams objectForKey:@"searchKeyword"];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.commodityListView];
    [self.view addSubview:self.searchView];
    
    [self.commodityListView loadDataWithSearchKeyword:self.searchKeyword];
    [self.searchNavigationView addSubview:self.searchView.navigateview];
    [self.searchView.navigateview setOrigin:CGPointMake(0, (self.searchNavigationView.height - self.searchView.navigateview.height)/2)];
}

-(void)refreshDataRequest{
    [self.commodityListView loadDataWithSearchKeyword:self.searchKeyword];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewDidUnload{
    self.commodityListView = nil;
    [super viewDidUnload];
}

-(void)backButtonClick:(id)sender{
    TBBackFromTarget(self);
}

-(UIView *)searchNavigationView{
    if (_searchNavigationView == nil) {
        _searchNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 64)];
        [self.view addSubview:_searchNavigationView];
    }
    return _searchNavigationView;
}

-(ManWuCommoditySearchListView *)commodityListView{
    if (_commodityListView == nil) {
        CGRect rect = self.view.bounds;
        rect.origin.y = self.searchNavigationView.bottom;
        rect.size.height = rect.size.height;
        _commodityListView = [[ManWuCommoditySearchListView alloc] initWithFrame:rect];
    }
    return _commodityListView;
}

-(ManWuSearchView *)searchView{
    if (_searchView == nil) {
        CGRect rect = self.view.bounds;
        rect.origin.y = self.searchNavigationView.bottom;
        rect.size.height = rect.size.height;
        _searchView = [[ManWuSearchView alloc] initWithFrame:rect viewCellClass:[ManWuSearchViewCell class] modelInfoClass:[ManWuSearchViewCellInfoItem class]];
        _searchView.searchBarRect = CGRectMake(searchViewBorder + 5, 0, _searchView.width - searchViewBorder - 5, _searchView.navigateview.height);
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, (_searchView.navigateview.height - searchViewBorder)/2, searchViewBorder, searchViewBorder)];
        [backButton setBackgroundColor:[UIColor clearColor]];
        [backButton setImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_searchView.navigateview insertSubview:backButton atIndex:0];
        _searchView.hidden = YES;
        WEAKSELF
        _searchView.searchStarkBlock = ^(UISearchBar* searchBar){
            STRONGSELF
            strongSelf.searchView.hidden = NO;
        };
        
        void (^searchBarOperationBlock)(UISearchBar* searchBar) = ^(UISearchBar* searchBar){
            STRONGSELF
            strongSelf.searchView.hidden = YES;
        };
        
        _searchView.searchCancelBlock = ^(UISearchBar* searchBar){
            searchBarOperationBlock(searchBar);
        };
        
        _searchView.searchEndBlock = ^(UISearchBar* searchBar,NSString* searchText){
            STRONGSELF
            searchBarOperationBlock(searchBar);
            [strongSelf.commodityListView loadDataWithSearchKeyword:searchText];
        };
    }
    return _searchView;
}

@end
