//
//  ManWuCommoditySearchListView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySearchListView.h"
#import "ManWuCommoditySortAndFiltView.h"
#import "ManWuCommodityFiltForDiscoverListView.h"
#import "ManWuCommoditySortListView.h"
#import "ManWuCommoditySortAndFiltModel.h"
#import "ManWuDiscoverSearchService.h"

#define sort_filt_view_height       (30.0 * SCREEN_SCALE)

@interface ManWuCommoditySearchListView()

@property (nonatomic,strong) CSLinearLayoutView         *container;

@property (nonatomic,strong) ManWuCommoditySortAndFiltView*   sortFiltHeadView;

@property (nonatomic,strong) ManWuCommoditySortListView*      sortListSelectView;

@property (nonatomic,strong) ManWuCommodityFiltForDiscoverListView *filtForDiscoverSelectView;

@property (nonatomic,strong) NSString                   *searchKeyword;

@property (nonatomic,strong) NSString                   *actIdKey;

@property (nonatomic,strong) NSString                   *filtKey;

@property (nonatomic,strong) NSString                   *sortKey;

@property (nonatomic,strong) ManWuDiscoverSearchService *searchListService;

@end


@implementation ManWuCommoditySearchListView

-(void)setupView{
    [super setupView];
    [self.container removeAllItems];
    
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, 0, 5.0, 0.0);
    
    CSLinearLayoutItem *sortFiltHeadViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                      initWithView:self.sortFiltHeadView];
    sortFiltHeadViewLayoutItem.padding             = padding;
    [self.container addItem:sortFiltHeadViewLayoutItem];
    
    
    
    [self.collectionViewCtl setColletionHeaderView:self.container];
    [self setCollectionService:self.searchListService];
}

#pragma mark - container

- (CSLinearLayoutView *)container {
    if (!_container) {
        float containerHeight = self.height -  TBSKU_BOTTOM_HEIGHT;
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, containerHeight);
        _container = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _container.autoAdjustFrameSize = YES;
        _container.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _container.backgroundColor  = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg1];
    }
    return _container;
}

-(ManWuCommoditySortAndFiltView *)sortFiltHeadView{
    if (_sortFiltHeadView == nil) {
        CGRect rect = self.collectionViewCtl.scrollView.bounds;
        rect.size.height = sort_filt_view_height;
        _sortFiltHeadView = [[ManWuCommoditySortAndFiltView alloc] initWithFrame:rect];
        WEAKSELF
        _sortFiltHeadView.leftButtonSelectedBlock = ^(UIView *leftButton){
            STRONGSELF
            strongSelf.sortListSelectView.hidden = NO;
            CGRect rect = strongSelf.sortListSelectView.collectionViewCtl.frame;
            CGRect sortFiltViewRect = [strongSelf.sortFiltHeadView convertRect:strongSelf.sortFiltHeadView.frame toView:strongSelf];
            rect.origin.y = CGRectGetMaxY(sortFiltViewRect);
            [strongSelf.sortListSelectView.collectionViewCtl setFrame:rect];
        };
        
        _sortFiltHeadView.rightButtonSelectedBlock = ^(UIView *rightButton){
            STRONGSELF
            strongSelf.filtForDiscoverSelectView.hidden = NO;
            CGRect rect = strongSelf.filtForDiscoverSelectView.collectionViewCtl.frame;
            CGRect sortFiltViewRect = [strongSelf.sortFiltHeadView convertRect:strongSelf.sortFiltHeadView.frame toView:strongSelf];
            rect.origin.y = CGRectGetMaxY(sortFiltViewRect);
            [strongSelf.filtForDiscoverSelectView.collectionViewCtl setFrame:rect];
        };
    }
    return _sortFiltHeadView;
}

-(ManWuCommoditySortListView *)sortListSelectView{
    if (_sortListSelectView == nil) {
        _sortListSelectView = [[ManWuCommoditySortListView alloc] initWithFrame:self.bounds viewCellClass:NSClassFromString(@"ManWuCommoditySortViewCell") modelCellClass:NSClassFromString(@"ManWuCommoditySortAndDiscountModelInfoCell")];
        WEAKSELF
        void(^sortListSelectBlock)(void) = ^(){
            STRONGSELF
            strongSelf.sortListSelectView.hidden = YES;
            [strongSelf.sortFiltHeadView clearButtonStatus];
        };
        _sortListSelectView.cancelListViewBlock =  ^(){
            if (sortListSelectBlock) {
                sortListSelectBlock();
            }
        };
        _sortListSelectView.sortListSelectedBlock = ^(KSCollectionViewController *collectionViewCtl,NSIndexPath* indexPath,KSDataSource* dataSource){
            STRONGSELF
            if (sortListSelectBlock) {
                sortListSelectBlock();
            }
            ManWuCommoditySortAndFiltModel* sortAndFiltModel = (ManWuCommoditySortAndFiltModel*)[dataSource getComponentItemWithIndex:[indexPath row]];
            NSDictionary* params = @{@"actIdKey":sortAndFiltModel.actIdKey?:defaultActIdKey};
            [strongSelf loadDataWithParams:params];
        };
        _sortListSelectView.hidden = YES;
        [self addSubview:_sortListSelectView];
    }
    return _sortListSelectView;
}

-(ManWuCommodityFiltForDiscoverListView *)filtForDiscoverSelectView{
    if (_filtForDiscoverSelectView == nil) {
        _filtForDiscoverSelectView = [[ManWuCommodityFiltForDiscoverListView alloc] initWithFrame:self.bounds viewCellClass:NSClassFromString(@"ManWuCommoditySortViewCell") modelCellClass:NSClassFromString(@"ManWuCommoditySortAndDiscountModelInfoCell")];
        WEAKSELF
        
        void(^flitForDiscoverBlock)(void) = ^(){
            STRONGSELF
            strongSelf.filtForDiscoverSelectView.hidden = YES;
            [strongSelf.sortFiltHeadView clearButtonStatus];
        };
        _filtForDiscoverSelectView.cancelListViewBlock =  ^(){
            if (flitForDiscoverBlock) {
                flitForDiscoverBlock();
            }
        };
        _filtForDiscoverSelectView.sortListSelectedBlock = ^(KSCollectionViewController *collectionViewCtl,NSIndexPath* indexPath,KSDataSource* dataSource){
            STRONGSELF
            if (flitForDiscoverBlock) {
                flitForDiscoverBlock();
            }
            ManWuCommoditySortAndFiltModel* sortAndFiltModel = (ManWuCommoditySortAndFiltModel*)[dataSource getComponentItemWithIndex:[indexPath row]];
            NSDictionary* params = @{@"sortKey":sortAndFiltModel.sortKey?:defaultSortKey};
            [strongSelf loadDataWithParams:params];
        };
        _filtForDiscoverSelectView.hidden = YES;
        [self addSubview:_filtForDiscoverSelectView];
    }
    return _filtForDiscoverSelectView;
}

-(ManWuDiscoverSearchService *)searchListService{
    if (_searchListService == nil) {
        _searchListService = [[ManWuDiscoverSearchService alloc] init];
    }
    return _searchListService;
}

-(void)loadDataWithSearchKeyword:(NSString*)searchKeyword{
    [self loadDataWithParams:@{@"searchKeyword":searchKeyword}];
}

-(void)loadDataWithParams:(NSDictionary*)params{
    BOOL needRefreshService = NO;
    
    NSString* actIdKey = params[@"actIdKey"];
    if (actIdKey && actIdKey != self.actIdKey) {
        self.actIdKey = actIdKey;
        needRefreshService = YES;
    }
    NSString* sortKey = params[@"sortKey"];
    if (sortKey && sortKey != self.sortKey) {
        // todo
        self.sortKey = sortKey;
        needRefreshService = YES;
    }
    NSString* filtKey = params[@"filtKey"];
    if (filtKey && filtKey != self.filtKey) {
        // todo
        self.filtKey = filtKey;
        needRefreshService = YES;
    }
    NSString* searchKeyword = params[@"searchKeyword"];
    if (searchKeyword && searchKeyword != self.searchKeyword) {
        // todo
        self.searchKeyword= searchKeyword;
        needRefreshService = YES;
    }
    if (!needRefreshService) {
        return;
    }
    // service todo
    [self.searchListService loadDiscoverSearchListDataWithWithKeyword:self.searchKeyword actId:self.actIdKey cid:self.filtKey sort:self.sortKey];
}

@end
