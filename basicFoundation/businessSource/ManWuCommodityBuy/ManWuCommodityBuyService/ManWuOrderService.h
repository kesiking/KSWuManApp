//
//  ManWuOrderService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSAdapterService.h"
#import "KSOrderModel.h"

@interface ManWuOrderService : KSAdapterService

-(void)createOrderWithUserId:(NSString*)userId
                   addressId:(NSString*)addressId
                       skuId:(NSString*)skuId
                      itemId:(NSString*)itemId
                      buyNum:(NSNumber*)buyNum
                    payPrice:(NSNumber*)payPrice
                  activityId:(NSString*)activityId
                   voucherId:(NSString*)voucherId;

-(void)loadOrderItemWithOrderId:(NSString*)orderId;

@end
