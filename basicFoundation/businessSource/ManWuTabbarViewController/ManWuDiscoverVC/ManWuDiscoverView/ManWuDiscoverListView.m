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

@interface ManWuDiscoverListView()

@property (nonatomic,strong) KSDataSource*      dataSourceRead;

@property (nonatomic,strong) KSDataSource*      dataSourceWrite;

@end

@implementation ManWuDiscoverListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.tableViewCtl.scrollView];
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20 ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
    }
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.tableViewCtl reloadData];
}

-(KSTableViewController *)tableViewCtl{
    if (_tableViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width - 2 * 8;
        frame.origin.x = 8;
        configObject.collectionCellSize = CGSizeZero;
        configObject.needQueueLoadData = NO;
        configObject.needRefreshView = NO;
        configObject.needNextPage = NO;
        configObject.needFootView = NO;
        _tableViewCtl = [[KSTableViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_tableViewCtl registerClass:[ManWuDiscoverViewCell class]];
        [_tableViewCtl setDataSourceRead:self.dataSourceRead];
        [_tableViewCtl setDataSourceWrite:self.dataSourceWrite];
    }
    return _tableViewCtl;
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
