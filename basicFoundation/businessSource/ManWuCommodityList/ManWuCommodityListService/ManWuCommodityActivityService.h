//
//  ManWuCommodityActivityService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"

@interface ManWuCommodityActivityService : KSAdapterService

-(void)loadCommodityActivityDataWithTypeId:(NSString*)typeId;

@end
