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

-(void)loadCommodityListDataWithWithActId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort{
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
    [self loadCommodityListDataWithWithActId:actId cid:cid sort:sort pageinationItem:pageinationItem];
}

-(void)loadCommodityListDataWithWithActId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort pageinationItem:(KSPaginationItem*)pageinationItem{
    NSDictionary* params = @{@"typeId":actId,@"cid":cid,@"sort":sort};
    self.jsonTopKey = nil;
    self.listPath = @"data";
    self.itemClass = [ManWuCommodityDetailModel class];
    if (self.pagedList) {
        [self.pagedList refresh];
    }
    [self loadPagedListWithAPIName:@"item/getCatItems.do" params:params pagination:pageinationItem version:nil];
}

@end
