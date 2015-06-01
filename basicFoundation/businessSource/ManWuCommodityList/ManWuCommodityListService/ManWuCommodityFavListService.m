//
//  ManWuCommodityFavListService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityFavListService.h"
#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityFavListService

-(void)loadCommodityFavorateData{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:@"store" forKey:@"type"];
    
    if ([KSAuthenticationCenter userId]) {
        [params setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    
    KSPaginationItem* pageinationItem = [[KSPaginationItem alloc] init];
    pageinationItem.pageSize = DEFAULT_PAGE_SIZE;
    self.jsonTopKey = nil;
    self.listPath = @"data";
    self.itemClass = [ManWuCommodityDetailModel class];
    if (self.pagedList) {
        [self.pagedList refresh];
    }
    self.needLogin = YES;
    self.itemClass = [ManWuCommodityDetailModel class];
    [self loadItemWithAPIName:@"collection/myItems.do" params:params version:nil];
}

-(void)loadCommodityLoveData{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:@"praise" forKey:@"type"];
    
    if ([KSAuthenticationCenter userId]) {
        [params setObject:[KSAuthenticationCenter userId] forKey:@"userId"];
    }
    self.needLogin = YES;
    self.itemClass = [ManWuCommodityDetailModel class];
    self.jsonTopKey = @"data";
    [self loadItemWithAPIName:@"collection/myItems.do" params:params version:nil];
}

@end
