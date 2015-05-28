//
//  ManWuCommodityActListService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/22.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityActListService.h"
#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityActListService

-(void)loadCommodityListDataWithActId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort{
    if (actId == nil) {
        actId = defaultActIdKey;
    }
    if (cid == nil) {
        cid = defaultCidKey;
    }
    if (sort == nil) {
        sort = defaultSortKey;
    }
    KSPaginationItem* pageinationItem = [[KSPaginationItem alloc] init];
    pageinationItem.pageSize = DEFAULT_PAGE_SIZE;
    [self loadCommodityListDataWithActId:actId cid:cid sort:sort pageinationItem:pageinationItem];
}

-(void)loadCommodityListDataWithActId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort pageinationItem:(KSPaginationItem*)pageinationItem{
    NSMutableDictionary* params = [@{@"typeId":actId,@"sort":sort} mutableCopy];
    if (cid) {
        [params setObject:cid forKey:@"parentCid"];
    }
    self.jsonTopKey = nil;
    self.listPath = @"data";
    self.itemClass = [ManWuCommodityDetailModel class];
    if (self.pagedList) {
        [self.pagedList refresh];
    }
    [self loadPagedListWithAPIName:@"activity/getActItems.do" params:params pagination:pageinationItem version:nil];
}


@end
