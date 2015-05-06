//
//  KSCollectionViewController.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-24.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSScrollViewServiceController.h"
#import "KSCollectionViewConfigObject.h"

typedef void(^collectionViewDidSelectedBlock) (UICollectionView* collectionView,NSIndexPath* indexPath,KSDataSource* dataSource);


@interface KSCollectionViewController : KSScrollViewServiceController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    UICollectionView*               _collectionView;
}

@property (nonatomic, strong) UIView*           colletionHeaderView;
@property (nonatomic, strong) UIView*           colletionFooterView;

@property (nonatomic, strong) collectionViewDidSelectedBlock  collectionViewDidSelectedBlock;


// init method
-(instancetype)initWithFrame:(CGRect)frame withConfigObject:(KSCollectionViewConfigObject*)configObject;

// 设置KSViewCell的类型，用于反射viewCell，在KSCollectionViewCell中使用
-(void)registerClass:(Class)viewCellClass;

// 获取collectionView
-(UICollectionView*)getCollectionView;

// 更新configObject
-(void)updateCollectionConfigObject:(KSCollectionViewConfigObject*)configObject;

// method used by subclass
// 公用函数 在子类的- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath中调用
-(void)configCollectionView:(UICollectionView *)collectionView withCollectionViewCell:(UICollectionViewCell*)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
