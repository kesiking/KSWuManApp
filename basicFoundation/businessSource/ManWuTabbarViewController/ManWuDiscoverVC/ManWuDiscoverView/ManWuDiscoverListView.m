//
//  ManWuDiscoverView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverListView.h"
#import "ManWuDiscoverViewCell.h"
#import "ManWuDiscoverCellModelInfoItem.h"
#import "KSSearchBasicView.h"
#import "ManWuSearchViewCell.h"
#import "ManWuSearchViewCellInfoItem.h"

#define WEAKSELF typeof(self) __weak __block weakSelf = self;
#define STRONGSELF typeof(self) __strong strongSelf = weakSelf;


@interface ManWuDiscoverListView()

@property (nonatomic,strong) KSDataSource*      dataSourceRead;

@property (nonatomic,strong) KSDataSource*      dataSourceWrite;

@property (nonatomic,strong) KSSearchBasicView* searchView;

@end

@implementation ManWuDiscoverListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.tableViewCtl.scrollView];
    [self addSubview:self.searchView];
    self.tableViewCtl.tableHeaderView = self.searchView.navigateview;
    /*
     * 注释mock数据
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20 ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
    }
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.tableViewCtl reloadData];
     */
}

-(void)setDataWithPageList:(NSArray *)arrayData extraDataSource:(NSDictionary *)extraInfoParams{
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.tableViewCtl reloadData];
}

-(KSTableViewController *)tableViewCtl{
    if (_tableViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width - 2 * 0;
        frame.origin.x = 0;
        configObject.collectionCellSize = CGSizeZero;
        configObject.needQueueLoadData = NO;
        configObject.needRefreshView = YES;
        configObject.needNextPage = NO;
        configObject.needFootView = NO;
        // 失败后用缓存刷新，如果成功则不做任何操作
        configObject.scrollViewCacheType = KSScrollViewConfigCacheType_afterFail;
        _tableViewCtl = [[KSTableViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_tableViewCtl registerClass:[ManWuDiscoverViewCell class]];
        [_tableViewCtl setDataSourceRead:self.dataSourceRead];
        [_tableViewCtl setDataSourceWrite:self.dataSourceWrite];
    }
    return _tableViewCtl;
}

-(KSSearchBasicView *)searchView{
    if (_searchView == nil) {
        _searchView = [[KSSearchBasicView alloc] initWithFrame:self.bounds viewCellClass:[ManWuSearchViewCell class] modelInfoClass:[ManWuSearchViewCellInfoItem class]];
        _searchView.hidden = YES;
        WEAKSELF
        _searchView.searchStarkBlock = ^(UISearchBar* searchBar){
            STRONGSELF
            strongSelf.searchView.hidden = NO;
            if (strongSelf.searchView.navigateview.superview != strongSelf.searchView) {
                [strongSelf.searchView.navigateview removeFromSuperview];
                [strongSelf.searchView addSubview:strongSelf.searchView.navigateview];
            }
        };
        
        void (^searchBarOperationBlock)(UISearchBar* searchBar) = ^(UISearchBar* searchBar){
            STRONGSELF
            if (strongSelf.searchView.navigateview.superview != strongSelf.tableViewCtl.scrollView) {
                [strongSelf.searchView.navigateview removeFromSuperview];
            }
            strongSelf.tableViewCtl.tableHeaderView = strongSelf.searchView.navigateview;
            strongSelf.searchView.hidden = YES;
        };
        
        _searchView.searchCancelBlock = ^(UISearchBar* searchBar){
            searchBarOperationBlock(searchBar);
        };
        
        _searchView.searchEndBlock = ^(UISearchBar* searchBar,NSString* searchText){
            STRONGSELF
            searchBarOperationBlock(searchBar);
            searchBar.text = @"";
            NSDictionary* params = @{@"searchKeyword":searchText};
            TBOpenURLFromTargetWithNativeParams(internalURL(KManWuCommodityListSearch), strongSelf,nil,params);
        };
    }
    return _searchView;
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
        _dataSourceRead.modelInfoItemClass = [ManWuDiscoverCellModelInfoItem class];
    }
    return _dataSourceRead;
}

-(KSDataSource *)dataSourceWrite {
    if (!_dataSourceWrite) {
        _dataSourceWrite = [[KSDataSource alloc]init];
        _dataSourceWrite.modelInfoItemClass = self.dataSourceRead.modelInfoItemClass;
    }
    return _dataSourceWrite;
}

@end
