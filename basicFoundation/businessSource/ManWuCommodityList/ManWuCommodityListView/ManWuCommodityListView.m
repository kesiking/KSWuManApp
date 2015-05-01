//
//  ManWuCommodityListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListView.h"
#import "ManWuViewCell.h"

@interface ManWuCommodityListView()

@property (nonatomic,strong) KSDataSource*      dataSourceRead;

@property (nonatomic,strong) KSDataSource*      dataSourceWrite;

@end

@implementation ManWuCommodityListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.collectionViewCtl.scrollView];
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10 ; i++) {
        WeAppComponentBaseItem* component = [[WeAppComponentBaseItem alloc] init];
        [arrayData addObject:component];
    }
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.collectionViewCtl reloadData];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor clearColor];
    UILabel* label = [[UILabel alloc] initWithFrame:view.bounds];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"headerView"];
    [view addSubview:label];
    [self.collectionViewCtl setColletionHeaderView:view];
}

-(KSCollectionViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width - 2 * 8;
        frame.origin.x = 8;
        configObject.collectionCellSize = CGSizeMake(frame.size.width/2, 190);
        _collectionViewCtl = [[KSCollectionViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl registerClass:[ManWuViewCell class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
        [_collectionViewCtl setDataSourceWrite:self.dataSourceWrite];
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

@end
