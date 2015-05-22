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

-(void)loadCommodityListDataWithActId:(NSString*)actId sort:(NSString*)sort{
    KSPaginationItem* pageinationItem = [[KSPaginationItem alloc] init];
    pageinationItem.pageSize = 20;
    [self loadCommodityListDataWithActId:actId sort:sort pageinationItem:pageinationItem];
}

-(void)loadCommodityListDataWithActId:(NSString*)actId sort:(NSString*)sort pageinationItem:(KSPaginationItem*)pageinationItem{
    NSDictionary* params = @{@"actId":actId,@"sort":sort,@"cid":@"1"};
    self.jsonTopKey = @"goodsList";
    self.itemClass = [ManWuCommodityDetailModel class];
    [self loadPagedListWithAPIName:@"item/getActItems.do" params:params pagination:pageinationItem version:nil];
}


@end
