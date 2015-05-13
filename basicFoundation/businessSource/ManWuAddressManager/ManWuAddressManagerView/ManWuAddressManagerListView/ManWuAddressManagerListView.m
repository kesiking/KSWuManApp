//
//  ManWuAddressManagerListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressManagerListView.h"
#import "ManWuAddressManagerViewCell.h"
#import "ManWuAddAddressView.h"

@interface ManWuAddressManagerListView()

@property (nonatomic,strong) KSDataSource*              dataSourceRead;

@property (nonatomic,strong) ManWuAddAddressView*       addAddressView;

@end

@implementation ManWuAddressManagerListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.collectionViewCtl.scrollView];
    [self addSubview:self.addAddressView];
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10 ; i++) {
        ManWuAddressInfoModel* component = [[ManWuAddressInfoModel alloc] init];
        if (i == 0) {
            component.isDefaultAddress = YES;
            component.addressDetail = [NSString stringWithFormat:@"测试"];
            component.phoneNum = [NSString stringWithFormat:@"13627632176"];
        }
        [arrayData addObject:component];
    }
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.collectionViewCtl reloadData];
}

-(void)refreshDataRequest{
    [self.collectionViewCtl reloadData];
}

-(KSTableViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        configObject.needQueueLoadData = NO;
        configObject.needNextPage = NO;
        configObject.needRefreshView = NO;
        CGRect frame = self.bounds;
        frame.size.height -= self.addAddressView.height;
        configObject.collectionCellSize = CGSizeMake(frame.size.width, 102);
        _collectionViewCtl = [[KSTableViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl registerClass:[ManWuAddressManagerViewCell class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
        [_collectionViewCtl.scrollView setBackgroundColor:RGB(0xf8, 0xf8, 0xf8)];
        WEAKSELF
        _collectionViewCtl.tableViewDidSelectedBlock = ^(UITableView* tableView,NSIndexPath* indexPath,KSDataSource* dataSource,KSCollectionViewConfigObject* configObject){
            STRONGSELF
            ManWuAddressInfoModel* addressComponent = (ManWuAddressInfoModel*)[dataSource getComponentItemWithIndex:[indexPath row]];
            // edit
            NSMutableDictionary* addressParams = [NSMutableDictionary dictionary];
            if (addressComponent) {
                [addressParams setObject:addressComponent forKey:kAddressModelKey];
            }
            if (strongSelf.addressDidChangeBlock) {
                [addressParams setObject:strongSelf.addressDidChangeBlock forKey:kAddressManagerSuccessBlock];

            }
            TBOpenURLFromTargetWithNativeParams(internalURL(kManWuAddressEdit), strongSelf.viewController, nil, addressParams);
        };
    }
    return _collectionViewCtl;
}

-(ManWuAddAddressView *)addAddressView{
    if (_addAddressView == nil) {
        _addAddressView = [[ManWuAddAddressView alloc] initWithFrame:CGRectMake(0, self.height - 44, self.width, 44)];
        WEAKSELF
        _addAddressView.addressAddClick = ^(){
            // add click todo  添加新的地址
            STRONGSELF
            NSDictionary *callBacks = nil;
            if (strongSelf.addressDidChangeBlock) {
                callBacks =[NSDictionary dictionaryWithObjectsAndKeys:strongSelf.addressDidChangeBlock, kAddressManagerSuccessBlock, nil];
            }
            TBOpenURLFromTargetWithNativeParams(kManWuAddressEdit, strongSelf.viewController, nil,callBacks);
        };
    }
    return _addAddressView;
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
    }
    return _dataSourceRead;
}

@end
