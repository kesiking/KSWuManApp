//
//  ManWuCommoditySortListView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommoditySortListView.h"
#import "ManWuCommoditySortAndFiltModel.h"

@interface ManWuCommoditySortListView()

@end

@implementation ManWuCommoditySortListView

-(void)initModel{
    NSArray* sortAndFiltArray = @[
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_all.jpg",
                                      @"titleText":@"全部"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_discount.png",
                                      @"titleText":@"折上折"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_specialForToday.jpg",
                                      @"titleText":@"今日特卖"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_buy.jpg",
                                      @"titleText":@"几元购"
                                      }
                                  ];
    NSArray* commoditySortAndFiltModels = [ManWuCommoditySortAndFiltModel modelArrayWithJSON:sortAndFiltArray];
    [self setSortListArray:commoditySortAndFiltModels];
}

@end
