//
//  ManWuCommodityFiltForDiscountListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortForDiscountListView.h"
#import "ManWuCommoditySortAndFiltModel.h"

@implementation ManWuCommoditySortForDiscountListView

-(void)initModel{
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
}

-(void)setupView{
    [super setupView];
    ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject).collectionColumn = 2;
    ((KSCollectionViewConfigObject*)self.collectionViewCtl.configObject).collectionCellSize = KSCGSizeMake(0, 60);
}

@end
