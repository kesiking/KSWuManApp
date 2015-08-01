//
//  ManWuAddressManagerListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressManagerListView.h"
#import "ManWuAddressManagerViewCell.h"
#import "ManWuAddressSelectViewCell.h"
#import "ManWuAddAddressView.h"
#import "ManWuAddressService.h"

@interface ManWuAddressManagerListView()

@property (nonatomic,strong) KSDataSource*              dataSourceRead;

@property (nonatomic,strong) ManWuAddAddressView*       addAddressView;

@property (nonatomic,strong) ManWuAddressService*       addressService;

@end

@implementation ManWuAddressManagerListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.collectionViewCtl.scrollView];
    [self addSubview:self.addAddressView];
    /*
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10 ; i++) {
        ManWuAddressInfoModel* component = [[ManWuAddressInfoModel alloc] init];
        if (i == 0) {
            component.defaultAddress = YES;
            component.address = [NSString stringWithFormat:@"测试"];
            component.phoneNum = [NSString stringWithFormat:@"13627632176"];
        }
        [arrayData addObject:component];
    }
    [self.dataSourceRead setDataWithPageList:arrayData extraDataSource:nil];
    [self.collectionViewCtl reloadData];
     */
    [self.addressService loadAddressList];
}

-(void)refreshDataRequest{
    [self.addressService loadAddressList];
}

-(KSTableViewController *)collectionViewCtl{
    if (_collectionViewCtl == nil) {
        KSCollectionViewConfigObject* configObject = [[KSCollectionViewConfigObject alloc] init];
        [configObject setupStandConfig];
        configObject.needQueueLoadData = NO;
        configObject.needNextPage = NO;
        configObject.needRefreshView = YES;
        CGRect frame = self.bounds;
        frame.size.height -= self.addAddressView.height;
//        configObject.collectionCellSize = KSCGSizeMake(frame.size.width, 102);
        configObject.collectionCellSize = KSCGSizeMake(frame.size.width, 145);

        _collectionViewCtl = [[KSTableViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl registerClass:[ManWuAddressSelectViewCell class]];
//        [_collectionViewCtl registerClass:[ManWuAddressManagerViewCell class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
        [_collectionViewCtl.scrollView setBackgroundColor:RGB(0xf8, 0xf8, 0xf8)];
        _collectionViewCtl.errorViewTitle = @"未添加收货地址，快去添加吧";
        [_collectionViewCtl setService:self.addressService];
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
        
        _collectionViewCtl.tableCellViewOperationBlock = ^(UITableView* tableView,NSIndexPath* indexPath,KSDataSource* dataSource,KSCollectionViewConfigObject* configObject){
            STRONGSELF
            [strongSelf.addressService loadAddressList];
        };
        
    }
    return _collectionViewCtl;
}

-(ManWuAddressService *)addressService{
    if (_addressService == nil) {
        _addressService = [[ManWuAddressService alloc] init];
    }
    return _addressService;
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
