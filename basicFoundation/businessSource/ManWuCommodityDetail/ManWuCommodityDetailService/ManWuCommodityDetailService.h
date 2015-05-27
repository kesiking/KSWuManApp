//
//  ManWuCommodityDetailService.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "ManWuCommodityDetailModel.h"

@interface ManWuCommodityDetailService : KSAdapterService

-(void)loadCommodityDetailInfoWithItemId:(NSString*)itemId;

-(void)loadLogin;

-(void)loadInvite;

@end
