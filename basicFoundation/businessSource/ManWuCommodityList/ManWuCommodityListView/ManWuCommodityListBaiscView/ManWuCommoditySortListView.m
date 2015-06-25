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
                                      @"imageUrl":@"manwu_commodity_filt_all",
                                      @"titleText":@"全部",
                                      @"actIdKey":@"0"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_discount",
                                      @"titleText":@"折上折",
                                      @"actIdKey":@"1"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_specialForToday",
                                      @"titleText":@"今日特卖",
                                      @"actIdKey":@"2"
                                      },
                                  @{
                                      @"imageUrl":@"manwu_commodity_filt_buy",
                                      @"titleText":@"几元购",
                                      @"actIdKey":@"3"
                                      }
                                  ];
    NSArray* commoditySortAndFiltModels = [ManWuCommoditySortAndFiltModel modelArrayWithJSON:sortAndFiltArray];
    [self setSortListArray:commoditySortAndFiltModels];
}

@end
