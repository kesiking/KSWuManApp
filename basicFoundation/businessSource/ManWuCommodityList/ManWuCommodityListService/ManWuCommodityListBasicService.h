//
//  ManWuCommodityListBasicService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

@interface ManWuCommodityListBasicService : KSAdapterService

-(void)loadCommodityListDataWithWithActId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort;

-(void)loadCommodityListDataWithWithActId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort pageinationItem:(KSPaginationItem*)pageinationItem;

@end
