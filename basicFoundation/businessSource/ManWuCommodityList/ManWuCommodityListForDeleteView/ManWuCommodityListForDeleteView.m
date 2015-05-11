//
//  ManWuCommodityListForDeleteView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListForDeleteView.h"
#import "ManWuCommodityDeleteBottom.h"
#import "ManWuFavViewCell.h"

@interface ManWuCommodityListForDeleteView()

@property (nonatomic,strong) NSString                     *filtKey;

@property (nonatomic,strong) NSString                     *sortKey;

@property (nonatomic,strong) ManWuCommodityDeleteBottom   *deleteView;

@property (nonatomic,assign) BOOL                          isEditing;

@end

@implementation ManWuCommodityListForDeleteView

-(void)setupView{
    [super setupView];
    [self addSubview:self.deleteView];
    KSCollectionViewConfigObject* configObject = ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject);
    configObject.collectionCellSize = CGSizeMake(configObject.collectionCellSize.width, 180);
    [self.collectionViewCtl registerClass:[ManWuFavViewCell class]];
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
    
    [self deleteBottomDoAnimation:isCollectionEdit];
}

-(void)deleteBottomDoAnimation:(BOOL)isCollectionEdit{
    CGRect rect = self.deleteView.frame;
    if (isCollectionEdit) {
        rect.origin.y = self.bottom - rect.size.height;
    }else{
        rect.origin.y = self.bottom;
    }
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [self.deleteView setFrame:rect];
    } completion:nil];
    _isCollectionEdit = isCollectionEdit;
}

-(ManWuCommodityDeleteBottom *)deleteView{
    if (_deleteView == nil) {
        CGRect rect = self.bounds;
        rect.size.height = 44;
        rect.origin.y = self.bottom;
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
    /*
     // 删除后不能继续删除的逻辑
     // 注释后为可连续删除
     KSCollectionViewConfigObject* configObject = ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject);
     configObject.isEditModel = NO;
     */
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
