//
//  ManWuCommodityListBasicService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListBasicService.h"
#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityListBasicService

-(void)loadCommodityListDataWithCid:(NSString*)cid sort:(NSString*)sort{
    KSPaginationItem* pageinationItem = [[KSPaginationItem alloc] init];
    pageinationItem.pageSize = DEFAULT_PAGE_SIZE;
    [self loadCommodityListDataWithCid:cid sort:sort pageinationItem:pageinationItem];
}

-(void)loadCommodityListDataWithCid:(NSString*)cid sort:(NSString*)sort pageinationItem:(KSPaginationItem*)pageinationItem{
    NSDictionary* params = @{@"cid":cid,@"sort":sort};
    self.jsonTopKey = nil;
    self.listPath = @"data";
    self.itemClass = [ManWuCommodityDetailModel class];
    [self loadPagedListWithAPIName:@"item/getCatItems.do" params:params pagination:pageinationItem version:nil];
}

@end
