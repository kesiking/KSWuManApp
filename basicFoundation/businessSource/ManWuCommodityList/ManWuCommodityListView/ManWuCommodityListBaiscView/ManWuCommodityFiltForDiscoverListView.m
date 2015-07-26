//
//  ManWuCommodityFiltForDiscoverListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFiltForDiscoverListView.h"
#import "ManWuCommoditySortAndFiltModel.h"

@implementation ManWuCommodityFiltForDiscoverListView

-(void)initModel{
    NSArray* sortAndFiltArray = @[
                                  @{
                                      @"imageUrl":@"manwu_commodity_sort_price",
                                      @"selectImageUrl":@"manwu_commodity_sort_select_price",
                                      @"titleText":@"按价格排序",
                                      @"sortKey":@"1"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_sort_like",
                                      @"selectImageUrl":@"manwu_commodity_sort_select_like",
                                      @"titleText":@"按人气排序",
                                      @"sortKey":@"2"
                                      }
                                  ];
    NSArray* commoditySortAndFiltModels = [ManWuCommoditySortAndFiltModel modelArrayWithJSON:sortAndFiltArray];
    [self setSortListArray:commoditySortAndFiltModels];
}

@end
