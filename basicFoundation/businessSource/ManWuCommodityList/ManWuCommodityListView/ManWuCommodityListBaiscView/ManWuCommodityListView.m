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

-(void)refreshDataRequest{
    if (_collectionViewCtl.service && _collectionViewCtl.service.pagedList) {
        [_collectionViewCtl.service refreshPagedList];
    }
}

-(void)dealloc{
    _collectionViewCtl = nil;
}

-(KSCollectionViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        [self setupCollectionViewConfigObject:configObject];
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width - 2 * 0;
        frame.origin.x = 0;
        configObject.collectionCellSize = CGSizeMake(frame.size.width/2, caculateNumber(180));
        _collectionViewCtl = [[KSCollectionViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl setErrorViewTitle:@"暂无数据，请稍后再试"];
        [_collectionViewCtl registerClass:[ManWuFavViewCell class]];
        [_collectionViewCtl getCollectionView].scrollEnabled = YES;
        [_collectionViewCtl getCollectionView].alwaysBounceVertical = YES;
    }
    return _collectionViewCtl;
}

-(void)setupCollectionViewConfigObject:(KSCollectionViewConfigObject*)configObject{
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark service 交给collectionViewCtl

-(void)setCollectionService:(KSAdapterService *)service{
    if (service != _collectionViewCtl.service) {
        _collectionViewCtl.service.delegate = nil;
        _collectionViewCtl.service = nil;
        _collectionViewCtl.service = service;
        WEAKSELF
        _collectionViewCtl.service.serviceDidStartLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            BOOL isNextPage = [[strongSelf.collectionViewCtl valueForKey:@"isNextPage"] boolValue];
            if (!isNextPage) {
                [strongSelf showLoadingView];
            }
        };
        _collectionViewCtl.service.serviceDidFinishLoadBlock = ^(WeAppBasicService* service){
            STRONGSELF
            [strongSelf hideLoadingView];
        };
        _collectionViewCtl.service.serviceDidFailLoadBlock = ^(WeAppBasicService* service, NSError* error){
            STRONGSELF
            [strongSelf hideLoadingView];
        };
    }
}

-(KSAdapterService*)getCollectionService{
    return (KSAdapterService*)_collectionViewCtl.service;
}

@end
