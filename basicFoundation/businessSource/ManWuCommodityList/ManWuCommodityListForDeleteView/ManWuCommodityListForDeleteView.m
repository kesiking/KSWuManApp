//
//  ManWuCommodityListForDeleteView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListForDeleteView.h"
#import "ManWuCommodityDeleteBottom.h"

@interface ManWuCommodityListForDeleteView()

@property (nonatomic,strong) NSString                     *filtKey;

@property (nonatomic,strong) NSString                     *sortKey;

@property (nonatomic,strong) ManWuCommodityDeleteBottom   *deleteView;

@property (nonatomic,assign) BOOL                          isEditing;

@end

@implementation ManWuCommodityListForDeleteView

-(void)setupView{
    [super setupView];
    CGRect rect = self.collectionViewCtl.frame;
    rect.size.height -= self.deleteView.height;
    [self.collectionViewCtl setFrame:rect];
    [self addSubview:self.deleteView];
}

-(void)setIsCollectionEdit:(BOOL)isCollectionEdit{
    // 如果当前正在操作不能执行reloadData
    if (self.isEditing) {
        return;
    }
    _isCollectionEdit = isCollectionEdit;
    KSCollectionViewConfigObject* configObject = ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject);
    configObject.isEditModel = isCollectionEdit;
    [self.collectionViewCtl reloadData];
}

-(ManWuCommodityDeleteBottom *)deleteView{
    if (_deleteView == nil) {
        CGRect rect = self.bounds;
        rect.size.height = 44;
        rect.origin.y = self.bottom - rect.size.height;
        _deleteView = [[ManWuCommodityDeleteBottom alloc] initWithFrame:rect];
        WEAKSELF
        _deleteView.deleteViewDidClickedBlock = ^(){
            STRONGSELF
            [strongSelf deleteSelectedCollectionCell];
        };
    }
    return _deleteView;
}

#pragma mark - deleteSelectCollectionCell 操作

- (void)deleteSelectedCollectionCell{
    KSCollectionViewConfigObject* configObject = ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject);
    configObject.isEditModel = NO;
    self.collectionViewCtl.scrollView.userInteractionEnabled = NO;
    self.isEditing = YES;
    [self.collectionViewCtl deleteCollectionCellProccessBlock:^(NSArray *collectionDeleteItems,KSDataSource* dataSource) {
        // 发送请求删除服务端数据
        [collectionDeleteItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSIndexPath class]]) {
                NSIndexPath* indexPath = obj;
                if ([dataSource count] <= [indexPath row]) {
                    *stop = YES;
                    return;
                }
                WeAppComponentBaseItem* componentItem = [dataSource getComponentItemWithIndex:[indexPath row]];
            }
        }];
    } completeBolck:^{
        [self.collectionViewCtl reloadData];
        self.collectionViewCtl.scrollView.userInteractionEnabled = YES;
        self.isEditing = NO;
    }];
}

#pragma mark - 加载数据

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
}

@end
