//
//  ManWuCommodityNewListService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityNewListService.h"
#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityNewListService

-(void)loadCommodityListData{
    KSPaginationItem* pageinationItem = [[KSPaginationItem alloc] init];
    pageinationItem.pageSize = DEFAULT_PAGE_SIZE;
    self.jsonTopKey = nil;
    self.listPath = @"data";
    self.itemClass = [ManWuCommodityDetailModel class];
    if (self.pagedList) {
        [self.pagedList refresh];
    }
#ifdef NEEDCACHE
    self.needCache = YES;
#endif
    [self loadPagedListWithAPIName:@"index/getNewItems.do" params:nil pagination:pageinationItem version:nil];
}

@end
