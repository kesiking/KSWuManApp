//
//  ManWuCommodityBasicSelectListView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"
#import "KSCollectionViewController.h"

typedef void(^sortListSelectedBlock) (KSCollectionViewController *collectionViewCtl,NSIndexPath* indexPath,KSDataSource* dataSource);

typedef void(^cancelListViewBlock) (void);


@interface ManWuCommodityBasicSelectListView : KSView

@property(nonatomic,strong) sortListSelectedBlock           sortListSelectedBlock;

@property(nonatomic,strong) cancelListViewBlock             cancelListViewBlock;

@property(nonatomic,strong) KSCollectionViewController*     collectionViewCtl;

-(instancetype)initWithFrame:(CGRect)frame viewCellClass:(Class)viewCellClass modelCellClass:(Class)modelCellClass;

// override only
-(void)initModel;

// 设置数据源
-(void)setSortListArray:(NSArray*)arrayData;

@end
