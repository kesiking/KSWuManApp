//
//  ManWuDiscoverService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverService.h"
#import "ManWuDiscoverModel.h"

#define allCidsKey @"1,2,3,4,5,6,7,8,9,10"

@implementation ManWuDiscoverService

-(void)loadCommodityListDataWithWithCategoryId:(NSString*)categoryId{
    if (categoryId == nil) {
        return;
    }
    NSDictionary* params = @{@"cids":@[categoryId]};
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuDiscoverModel class];
    [self loadDataListWithAPIName:@"category/batchGetCategories.do" params:params version:nil];
}

-(void)loadAllCategoryCommodityListData{
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuDiscoverModel class];
    [self loadDataListWithAPIName:@"category/getAllCats.do" params:nil version:nil];
    /*
    NSDictionary* params = @{@"cids":allCidsKey};
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuDiscoverModel class];
    [self loadDataListWithAPIName:@"category/batchGetCategories.do" params:params version:nil];
     */
}

-(void)loadRootCategoryListData{
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuDiscoverModel class];
    [self loadDataListWithAPIName:@"category/getRootCats.do" params:nil version:nil];
}

@end
