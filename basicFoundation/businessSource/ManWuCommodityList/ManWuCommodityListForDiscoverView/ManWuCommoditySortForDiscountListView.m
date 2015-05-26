//
//  ManWuCommodityFiltForDiscountListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortForDiscountListView.h"
#import "ManWuCommoditySortAndFiltModel.h"
#import "ManWuDiscoverService.h"

@interface ManWuCommoditySortForDiscountListView()<WeAppBasicServiceDelegate>

@property (nonatomic,strong) ManWuDiscoverService  *sortForDiscountListService;

@end

@implementation ManWuCommoditySortForDiscountListView

-(void)initModel{
    /*
    NSArray* sortAndFiltArray = @[
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_all.jpg",
                                      @"titleText":@"按价格排序",
                                      @"subTitleText":@"for women",
                                      @"filtKey":@"1"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_discount.png",
                                      @"titleText":@"按人气排序",
                                      @"subTitleText":@"按价格排序",
                                      @"filtKey":@"2"
                                      }
                                  ];
    NSArray* commoditySortAndFiltModels = [ManWuCommoditySortAndFiltModel modelArrayWithJSON:sortAndFiltArray];
    [self setSortListArray:commoditySortAndFiltModels];
     */
    [self.sortForDiscountListService loadAllCategoryCommodityListData];
}

-(void)setupView{
    [super setupView];
    ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject).collectionColumn = 2;
    ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject).collectionCellSize = KSCGSizeMake(0, 60);
}

-(ManWuDiscoverService *)sortForDiscountListService{
    if (_sortForDiscountListService == nil) {
        _sortForDiscountListService = [[ManWuDiscoverService alloc] init];
        _sortForDiscountListService.delegate = self;
    }
    return _sortForDiscountListService;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

- (void)serviceDidStartLoad:(WeAppBasicService *)service{
   
}

- (void)serviceDidFinishLoad:(WeAppBasicService *)service{
    if (service && [service.dataList count] > 0) {
        [self setSortListArray:service.dataList];
    }
}

- (void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError*)error{
    
}

@end
