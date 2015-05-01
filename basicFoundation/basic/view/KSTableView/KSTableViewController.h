//
//  KSTableViewController.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSScrollViewServiceController.h"
#import "KSCollectionViewConfigObject.h"

@interface KSTableViewController : KSScrollViewServiceController<UITableViewDataSource, UITableViewDelegate>{
    UITableView*                 _tableView;
}

@property (nonatomic, strong) UIView*           tableHeaderView;
@property (nonatomic, strong) UIView*           tableFooterView;

// init method
-(instancetype)initWithFrame:(CGRect)frame withConfigObject:(KSCollectionViewConfigObject*)configObject;

// 设置KSViewCell的类型，用于反射viewCell，在KSCollectionViewCell中使用
-(void)registerClass:(Class)viewCellClass;

// 获取collectionView
-(UITableView*)getTableView;

// 更新configObject
-(void)updateCollectionConfigObject:(KSCollectionViewConfigObject*)configObject;

// method used by subclass
// 公用函数 在子类的- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath中调用
-(void)configTableView:(UITableView *)tableView withCollectionViewCell:(UITableViewCell*)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
