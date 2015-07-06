//
//  ManWuDiscoverSearchService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

@interface ManWuDiscoverSearchService : KSAdapterService

-(void)loadDiscoverSearchListDataWithWithKeyword:(NSString*)keyword actId:(NSString*)actId cid:(NSString*)cid sort:(NSString*)sort;

-(void)loadDiscoverSearchNumberWithKeyword:(NSString*)keyword;

@end
