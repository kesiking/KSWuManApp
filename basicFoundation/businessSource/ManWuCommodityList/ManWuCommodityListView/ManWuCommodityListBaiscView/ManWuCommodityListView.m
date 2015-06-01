//
//  ManWuCommodityListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListView.h"
//#import "ManWuViewCell.h"
#import "ManWuFavViewCell.h"

@interface ManWuCommodityListView()

@property (nonatomic,strong) KSDataSource*      dataSourceRead;

@property (nonatomic,strong) KSDataSource*      dataSourceWrite;

@end

@implementation ManWuCommodityListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.collectionViewCtl.scrollView];
    /*
     * for mock
    NSMutableArray* arrayData = [NSMutableArray array];
    for (int i = 0; i < 10 ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
    }
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.collectionViewCtl reloadData];
     */
}

-(void)dealloc{
    _collectionViewCtl = nil;
    _dataSourceRead = nil;
    _dataSourceWrite = nil;
}

-(KSCollectionViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width - 2 * 8;
        frame.origin.x = 8;
        configObject.collectionCellSize = CGSizeMake(frame.size.width/2, caculateNumber(180));
        _collectionViewCtl = [[KSCollectionViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl setErrorViewTitle:@"服务器在偷懒，请稍后再试"];
        [_collectionViewCtl registerClass:[ManWuFavViewCell class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
        [_collectionViewCtl setDataSourceWrite:self.dataSourceWrite];
        [_collectionViewCtl getCollectionView].scrollEnabled = YES;
        [_collectionViewCtl getCollectionView].alwaysBounceVertical = YES;
    }
    return _collectionViewCtl;
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
    }
    return _dataSourceRead;
}

-(KSDataSource *)dataSourceWrite {
    if (!_dataSourceWrite) {
        _dataSourceWrite = [[KSDataSource alloc]init];
    }
    return _dataSourceWrite;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark service 交给collectionViewCtl

-(void)setCollectionService:(KSAdapterService *)service{
    if (service != _collectionViewCtl.service) {
        _collectionViewCtl.service.delegate = nil;
        _collectionViewCtl.service = nil;
        _collectionViewCtl.service = service;
    }
}

-(KSAdapterService*)getCollectionService{
    return (KSAdapterService*)_collectionViewCtl.service;
}

@end
