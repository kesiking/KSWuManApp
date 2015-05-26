//
//  ManWuCommodityBasicSelectListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityBasicSelectListView.h"

#define commoditySortCellHeight (44.0)

@interface ManWuCommodityBasicSelectListView()

@property (nonatomic,strong) KSDataSource*          dataSourceRead;

@property (nonatomic,strong) Class                  viewCellClass;

@property (nonatomic,strong) Class                  modelCellClass;

@property (nonatomic,strong) UIButton*              cancelButton;

@end

@implementation ManWuCommodityBasicSelectListView

-(instancetype)initWithFrame:(CGRect)frame viewCellClass:(Class)viewCellClass modelCellClass:(Class)modelCellClass{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewCellClass = viewCellClass;
        self.modelCellClass = modelCellClass;
        [self initModel];
    }
    return self;
}

-(void)initModel{
    
}

-(void)setupView{
    [super setupView];
    [self addSubview:self.collectionViewCtl.scrollView];
    [self insertSubview:self.cancelButton belowSubview:self.collectionViewCtl.scrollView];
}

-(void)setViewCellClass:(Class)viewCellClass{
    _viewCellClass = viewCellClass;
    [_collectionViewCtl registerClass:viewCellClass];
}

-(void)setModelCellClass:(Class)modelCellClass{
    _modelCellClass = modelCellClass;
    [_dataSourceRead setModelInfoItemClass:modelCellClass];
}

-(void)setSortListArray:(NSArray*)arrayData{
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self setupTableViewHeight];
    [self.collectionViewCtl reloadData];
}

-(void)setupTableViewHeight{
    CGFloat totleHeight = 0;
    if (((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject).collectionCellSize.height != 0){
        totleHeight = ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject).collectionCellSize.height * [self.dataSourceRead count];
    }else{
        for (NSUInteger index = 0; index < [self.dataSourceRead count]; index++) {
            KSCellModelInfoItem* cellModelInfoItem = [self.dataSourceRead getComponentModelInfoItemWithIndex:index];
            totleHeight += cellModelInfoItem.frame.size.height;
        }
    }
    
    CGRect frame = self.collectionViewCtl.frame;
    frame.size.height = totleHeight;
    [self.collectionViewCtl setFrame:frame];
}

-(KSCollectionViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width - 2 * 0;
        frame.origin.x = 0;
        configObject.collectionCellSize = CGSizeZero;
        configObject.needQueueLoadData = NO;
        configObject.needRefreshView = NO;
        configObject.needNextPage = NO;
        configObject.needFootView = NO;
        configObject.collectionCellSize = CGSizeMake(self.width, caculateNumber(commoditySortCellHeight));
        _collectionViewCtl = [[KSCollectionViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl registerClass:[self.viewCellClass class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
        WEAKSELF
        _collectionViewCtl.collectionViewDidSelectedBlock = ^(UICollectionView* collectionView,NSIndexPath* indexPath,KSDataSource* dataSource,KSCollectionViewConfigObject* configObject){
            STRONGSELF
            if (strongSelf.sortListSelectedBlock) {
                strongSelf.sortListSelectedBlock(strongSelf
                                                 .collectionViewCtl,indexPath,dataSource);
            }
        };
    }
    return _collectionViewCtl;
}

-(UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:self.bounds];
        [_cancelButton setBackgroundColor:[UIColor clearColor]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(void)cancelButtonClick:(id)sender{
    if (self.cancelListViewBlock) {
        self.cancelListViewBlock();
    }
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
        _dataSourceRead.modelInfoItemClass = [self.modelCellClass class];
    }
    return _dataSourceRead;
}

@end
