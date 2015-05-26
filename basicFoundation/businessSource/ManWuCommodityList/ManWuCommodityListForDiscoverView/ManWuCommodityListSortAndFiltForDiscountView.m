//
//  ManWuCommodityListSortAndFiltForDiscountView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListSortAndFiltForDiscountView.h"
#import "ManWuCommoditySortAndFiltView.h"
#import "ManWuDiiscountInfoDescriptionView.h"
#import "ManWuCommodityFiltForDiscoverListView.h"
#import "ManWuCommoditySortForDiscountListView.h"
#import "ManWuCommoditySortListView.h"
#import "ManWuCommoditySortAndFiltModel.h"
#import "ManWuCommodityFiltTagListView.h"
#import "ManWuCommodityActListService.h"
#import "ManWuDiscoverModel.h"

#define sort_filt_view_height       (30.0 * SCREEN_SCALE)
#define discountInfo_height         (108.0 * SCREEN_SCALE)


@interface ManWuCommodityListSortAndFiltForDiscountView()

@property (nonatomic, strong) CSLinearLayoutView             *container;

@property (nonatomic, strong) ManWuDiiscountInfoDescriptionView     *discountInfo;

// 刷选头
@property (nonatomic,strong) ManWuCommoditySortAndFiltView*   sortFiltHeadView;
// 筛选 弄倒了
@property (nonatomic,strong) ManWuCommoditySortForDiscountListView*      sortListSelectView;
// 排序 弄倒了
@property (nonatomic,strong) ManWuCommodityFiltForDiscoverListView *filtForDiscoverSelectView;

@property (nonatomic,strong) ManWuCommodityFiltTagListView *filtTagListView;

@property (nonatomic,strong) NSString                          *actIdKey;

@property (nonatomic,strong) NSString                          *filtKey;

@property (nonatomic,strong) NSString                          *sortKey;

@property (nonatomic,strong) ManWuCommodityActListService      *actListService;

@end

@implementation ManWuCommodityListSortAndFiltForDiscountView

-(void)setupView{
    [super setupView];
    [self.container removeAllItems];
    
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, 0, 5.0, 0.0);
    
    CSLinearLayoutItem *discountInfoLayoutItem = [[CSLinearLayoutItem alloc]
                                                  initWithView:self.discountInfo];
    discountInfoLayoutItem.padding             = padding;
    [self.container addItem:discountInfoLayoutItem];
    
    CSLinearLayoutItem *sortFiltHeadViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.sortFiltHeadView];
    sortFiltHeadViewLayoutItem.padding             = padding;
    [self.container addItem:sortFiltHeadViewLayoutItem];
    
    
    
    [self.collectionViewCtl setColletionHeaderView:self.container];
    [self setCollectionService:self.actListService];
    
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

#pragma mark - discountInfo

-(ManWuDiiscountInfoDescriptionView *)discountInfo{
    if (_discountInfo == nil) {
        _discountInfo = [[ManWuDiiscountInfoDescriptionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, discountInfo_height)];
        _discountInfo.userInteractionEnabled = NO;
        _discountInfo.backgroundColor = [UIColor whiteColor];
    }
    return _discountInfo;
}

#pragma mark - sortFiltHeadView 排序与筛选

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
            CGRect sortFiltViewRect = [strongSelf.container convertRect:strongSelf.container.frame toView:strongSelf];
            rect.origin.y = CGRectGetMaxY(sortFiltViewRect);
            [strongSelf.sortListSelectView.collectionViewCtl setFrame:rect];
        };
        
        _sortFiltHeadView.rightButtonSelectedBlock = ^(UIView *rightButton){
            STRONGSELF
            strongSelf.filtForDiscoverSelectView.hidden = NO;
            CGRect rect = strongSelf.filtForDiscoverSelectView.collectionViewCtl.frame;
            CGRect sortFiltViewRect = [strongSelf.container convertRect:strongSelf.container.frame toView:strongSelf];
            rect.origin.y = CGRectGetMaxY(sortFiltViewRect);
            [strongSelf.filtForDiscoverSelectView.collectionViewCtl setFrame:rect];
        };
    }
    return _sortFiltHeadView;
}

#pragma mark - sortListSelectView 筛选选择list

-(ManWuCommoditySortForDiscountListView *)sortListSelectView{
    if (_sortListSelectView == nil) {
        _sortListSelectView = [[ManWuCommoditySortForDiscountListView alloc] initWithFrame:self.bounds viewCellClass:NSClassFromString(@"ManWuCommoditySortForDiscountViewCell") modelCellClass:NSClassFromString(@"ManWuCommoditySortAndDiscountModelInfoCell")];
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
            ManWuDiscoverModel* sortAndFiltModel = (ManWuDiscoverModel*)[dataSource getComponentItemWithIndex:[indexPath row]];
           
            [strongSelf.filtTagListView setDataWithPageList:sortAndFiltModel.leafCategoryList title:sortAndFiltModel.name];
            CGRect rect = strongSelf.filtTagListView.tagListLayoutView.frame;
            CGRect sortFiltViewRect = [strongSelf.container convertRect:strongSelf.container.frame toView:strongSelf];
            rect.origin.y = CGRectGetMaxY(sortFiltViewRect);
            [strongSelf.filtTagListView.tagListLayoutView setOrigin:CGPointMake(rect.origin.x, rect.origin.y)];
            strongSelf.filtTagListView.hidden = NO;
        };
        _sortListSelectView.hidden = YES;
        [self addSubview:_sortListSelectView];
    }
    return _sortListSelectView;
}

#pragma mark - filtForDiscoverSelectView 排序选择list

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

-(ManWuCommodityFiltTagListView *)filtTagListView{
    if (_filtTagListView == nil) {
        _filtTagListView = [[ManWuCommodityFiltTagListView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        WEAKSELF
        void(^flitTagListViewBlock)(void) = ^(){
            STRONGSELF
            strongSelf.filtTagListView.hidden = YES;
        };
        
        _filtTagListView.cancelListViewBlock =  ^(){
            if (flitTagListViewBlock) {
                flitTagListViewBlock();
            }
        };
        
        _filtTagListView.filtTagListViewSelectedBlock = ^(NSUInteger index,WeAppComponentBaseItem* componentItem){
            STRONGSELF
            if (flitTagListViewBlock) {
                flitTagListViewBlock();
            }
            if (![componentItem isKindOfClass:[ManWuDiscoverModel class]]) {
                return;
            }
            ManWuDiscoverModel* sortAndFiltModel = (ManWuDiscoverModel*)componentItem;
            NSDictionary* params = @{@"filtKey":sortAndFiltModel.cid?:defaultCidKey};
            [strongSelf loadDataWithParams:params];
        };
        
        [self addSubview:_filtTagListView];
    }
    return _filtTagListView;
}

-(ManWuCommodityActListService *)actListService{
    if (_actListService == nil) {
        _actListService = [[ManWuCommodityActListService alloc] init];
    }
    return _actListService;
}

#pragma mark - 加载数据

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
    if (!needRefreshService) {
        return;
    }
    // service todo
    [self.actListService loadCommodityListDataWithActId:self.actIdKey cid:self.filtKey sort:self.sortKey];
}


@end
