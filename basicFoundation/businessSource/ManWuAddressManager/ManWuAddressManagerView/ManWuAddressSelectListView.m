//
//  ManWuAddressManagerListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressSelectListView.h"
#import "ManWuAddressSelectViewCell.h"
#import "ManWuAddressService.h"

@interface ManWuAddressSelectListView()

@property (nonatomic,strong) KSDataSource*              dataSourceRead;

@property (nonatomic,strong) ManWuAddressService*       addressService;

@end

@implementation ManWuAddressSelectListView

-(void)setupView{
    [super setupView];
    [self addSubview:self.collectionViewCtl.scrollView];
    /*
    NSMutableArray* arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10 ; i++) {
        ManWuAddressInfoModel* component = [[ManWuAddressInfoModel alloc] init];
        if (i == 0) {
            component.defaultAddress = YES;
            component.address = [NSString stringWithFormat:@"测试"];
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
        CGRect frame = self.bounds;
        configObject.collectionCellSize = KSCGSizeMake(frame.size.width, 115);
        _collectionViewCtl = [[KSTableViewController alloc] initWithFrame:frame withConfigObject:configObject];
        [_collectionViewCtl registerClass:[ManWuAddressSelectViewCell class]];
        [_collectionViewCtl setDataSourceRead:self.dataSourceRead];
        [_collectionViewCtl.scrollView setBackgroundColor:RGB(0xf8, 0xf8, 0xf8)];
        [_collectionViewCtl setService:self.addressService];
        WEAKSELF
        _collectionViewCtl.tableViewDidSelectedBlock = ^(UITableView* tableView,NSIndexPath* indexPath,KSDataSource* dataSource,KSCollectionViewConfigObject* configObject){
            STRONGSELF
            ManWuAddressInfoModel* selectAddressComponent = (ManWuAddressInfoModel*)[dataSource getComponentItemWithIndex:[indexPath row]];
            /*
            // 不用更换默认的展示
            for (NSUInteger index = 0; index < [dataSource count]; index ++) {
                ManWuAddressInfoModel* component = (ManWuAddressInfoModel*)[dataSource getComponentItemWithIndex:index];
                if (index == [indexPath row]) {
                    component.isDefaultAddress = YES;
                    selectAddressComponent = component;
                }else{
                    component.isDefaultAddress = NO;
                }
                // 不用发请求通知服务端改变地址状态，因为是临时选择
                [tableView reloadData];
            }
             */
            [strongSelf doCallBackWithAddressComponent:selectAddressComponent];
        };
    }
    return _collectionViewCtl;
}

-(KSDataSource *)dataSourceRead {
    if (!_dataSourceRead) {
        _dataSourceRead = [[KSDataSource alloc]init];
    }
    return _dataSourceRead;
}

-(ManWuAddressService *)addressService{
    if (_addressService == nil) {
        _addressService = [[ManWuAddressService alloc] init];
    }
    return _addressService;
}

-(void)doCallBackWithAddressComponent:(ManWuAddressInfoModel*)addressComponent{
    if (self.addressSelectBlock) {
        self.addressSelectBlock(addressComponent);
    }
}

@end
