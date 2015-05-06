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
                                      @"imageUrl":@"manwu_commodity_filt_all.jpg",
                                      @"titleText":@"按价格排序"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_discount.png",
                                      @"titleText":@"按人气排序"
                                      }
                                  ];
    NSArray* commoditySortAndFiltModels = [ManWuCommoditySortAndFiltModel modelArrayWithJSON:sortAndFiltArray];
    [self setSortListArray:commoditySortAndFiltModels];
}

@end
