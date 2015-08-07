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

#define commoditySortForDiscountUserNativeCategory

@interface ManWuCommoditySortForDiscountListView()<WeAppBasicServiceDelegate>

@property (nonatomic,strong) ManWuDiscoverService  *sortForDiscountListService;

@end

@implementation ManWuCommoditySortForDiscountListView

-(void)initModel{
#ifdef commoditySortForDiscountUserNativeCategory
    // 从本地获取
    NSArray* sortAndFiltArray = @[
                                  @{
                                      @"imageUrl":@"manwu_category_dress",
                                      @"selectImageUrl":@"manwu_category_select_dress",

                                      @"titleText":@"Women's Cloth",
                                      @"subTitleText":@"女装",
                                      @"cid":@"10"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_category_shirt",
                                      @"selectImageUrl":@"manwu_category_select_shirt",

                                      @"titleText":@"Men's Cloth",
                                      @"subTitleText":@"男装",
                                      @"cid":@"1"
                                      },
                                     @{
                                      @"imageUrl":@"manwu_category_high_heeled_show",
                                      @"selectImageUrl":@"manwu_category_high_heeled_select_show",
                                      
                                      @"titleText":@"Women's Shoes",
                                      @"subTitleText":@"女鞋",
                                      @"cid":@"11"
                                      },
                                     @{
                                      @"imageUrl":@"manwu_category_man_shoe",
                                      @"selectImageUrl":@"manwu_category_man_select_shoe",
                                      
                                      @"titleText":@"Men's Shoes",
                                      @"subTitleText":@"男鞋",
                                      @"cid":@"4"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_category_bra",
                                      @"selectImageUrl":@"manwu_category_select_bra",
                                      
                                      @"titleText":@"UnderWear",
                                      @"subTitleText":@"内衣",
                                      @"cid":@"17"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_category_necklace",
                                      @"selectImageUrl":@"manwu_category_select_necklace",
                                      
                                      @"titleText":@"Ornament",
                                      @"subTitleText":@"配饰",
                                      @"cid":@"18"
                                      },
                                      @{
                                      @"imageUrl":@"manwu_category_all",
                                      @"selectImageUrl":@"manwu_category_select_all",
                                      
                                      @"titleText":@"All for you",
                                      @"subTitleText":@"全部",
                                      @"cid":@"0"
                                      }
                                  ];
    NSArray* commoditySortAndFiltModels = [ManWuCommoditySortAndFiltModel modelArrayWithJSON:sortAndFiltArray];
    self.collectionViewCtl.selectIndexPath = [NSIndexPath indexPathForRow:[commoditySortAndFiltModels count] - 1 inSection:0];
    [self setSortListArray:commoditySortAndFiltModels];
#else
    // 从网络获取
    [self.sortForDiscountListService loadRootCategoryListData];
#endif
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
