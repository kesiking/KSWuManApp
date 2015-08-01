//
//  ManWuVoucherService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "ManWuVoucherModel.h"

@interface ManWuVoucherService : KSAdapterService

-(void)loadVoucherWithItemId:(NSString*)itemId
                      buyNum:(NSNumber*)buyNum;

-(void)fetchVoucherWithCidId:(NSNumber*)cidId
                      userId:(NSString*)userId
              activityTypeId:(NSNumber*)activityTypeId
                    payPrice:(NSNumber*)payPrice;

@end
