//
//  ManWuCommodityListWithSortAndFiltView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListWithSortAndFiltBasicView.h"
#import "ManWuCommoditySortAndFiltView.h"
#import "ManWuCommodityFiltForDiscoverListView.h"
#import "ManWuCommoditySortListView.h"
#import "ManWuCommoditySortAndFiltModel.h"
#import "ManWuCommodityListBasicService.h"

#define sort_filt_view_height (30.0)

@interface ManWuCommodityListWithSortAndFiltView()

@property (nonatomic,strong) ManWuCommoditySortAndFiltView*   sortFiltHeadView;

@property (nonatomic,strong) ManWuCommoditySortListView*      sortListSelectView;

@property (nonatomic,strong) ManWuCommodityFiltForDiscoverListView *filtForDiscoverSelectView;

@property (nonatomic,strong) NSString                          *filtKey;

@property (nonatomic,strong) NSString                          *sortKey;

@property (nonatomic,strong) ManWuCommodityListBasicService    *discoverService;

@end

@implementation ManWuCommodityListWithSortAndFiltView

-(void)setupView{
    [super setupView];
    [self.collectionViewCtl setColletionHeaderView:self.sortFiltHeadView];
    [self setCollectionService:self.discoverService];
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
            NSDictionary* params = @{@"sortKey":sortAndFiltModel.titleText};
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
            NSDictionary* params = @{@"filtKey":sortAndFiltModel.titleText};
            [strongSelf loadDataWithParams:params];
        };
        _filtForDiscoverSelectView.hidden = YES;
        [self addSubview:_filtForDiscoverSelectView];
    }
    return _filtForDiscoverSelectView;
}

-(ManWuCommodityListBasicService *)discoverService{
    if (_discoverService == nil) {
        _discoverService = [[ManWuCommodityListBasicService alloc] init];
    }
    return _discoverService;
}

-(void)loadDataWithParams:(NSDictionary*)params{
    NSString* sortKey = params[@"sortKey"];
    if (sortKey) {
        // todo
        self.sortKey = sortKey;
    }
    NSString* filtKey = params[@"filtKey"];
    if (filtKey) {
        // todo
        self.filtKey = filtKey;
    }
    // service todo
    [self.discoverService loadCommodityListDataWithCid:self.filtKey sort:self.sortKey];
}

@end
