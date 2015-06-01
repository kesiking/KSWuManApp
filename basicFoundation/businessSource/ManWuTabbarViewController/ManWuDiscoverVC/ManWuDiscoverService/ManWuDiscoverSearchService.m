//
//  ManWuDiscoverSearchService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverSearchService.h"
#import "ManWuCommodityDetailModel.h"

@implementation ManWuDiscoverSearchService

-(void)loadDiscoverSearchListDataWithWithKeyword:(NSString*)keyword actId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort{
    if ([WeAppUtils isEmpty:keyword]) {
        return;
    }
    
    
    NSMutableDictionary* params = [@{@"content":keyword} mutableCopy];
    if (actId) {
        [params setObject:actId forKey:@"typeId"];
    }
    if (sort) {
        [params setObject:sort forKey:@"sort"];
    }
    if (cid) {
        [params setObject:sort forKey:@"cid"];
    }
    KSPaginationItem* pageinationItem = [[KSPaginationItem alloc] init];
    pageinationItem.pageSize = DEFAULT_PAGE_SIZE;
    self.jsonTopKey = nil;
    self.listPath = @"data";
    self.itemClass = [ManWuCommodityDetailModel class];
    if (self.pagedList) {
        [self.pagedList refresh];
    }
    
    [self loadPagedListWithAPIName:@"item/searchItems.do" params:params pagination:pageinationItem version:nil];
    
}

@end
