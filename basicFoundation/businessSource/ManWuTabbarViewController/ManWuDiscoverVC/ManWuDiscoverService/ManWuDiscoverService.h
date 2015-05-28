//
//  ManWuDiscoverService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "ManWuDiscoverModel.h"

@interface ManWuDiscoverService : KSAdapterService

-(void)loadCommodityListDataWithWithCategoryId:(NSString*)categoryId;

-(void)loadAllCategoryCommodityListData;

-(void)loadRootCategoryListData;

@end
