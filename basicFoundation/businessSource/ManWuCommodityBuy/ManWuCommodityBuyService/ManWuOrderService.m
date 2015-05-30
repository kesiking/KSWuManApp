//
//  ManWuOrderService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuOrderService.h"

@implementation ManWuOrderService

-(void)createOrderWithUserId:(NSString*)userId
                   addressId:(NSString*)addressId
                       skuId:(NSString*)skuId
                      itemId:(NSString*)itemId
                      buyNum:(NSNumber*)buyNum
                    payPrice:(NSNumber*)payPrice
                  activityId:(NSString*)activityId
                   voucherId:(NSString*)voucherId{
    if ([WeAppUtils isEmpty:userId]
        || [WeAppUtils isEmpty:addressId]
        || [WeAppUtils isEmpty:skuId]
        || [WeAppUtils isEmpty:itemId]
        || [WeAppUtils isEmpty:buyNum]
        || [WeAppUtils isEmpty:payPrice]) {
        [WeAppToast toast:@"缺少必要参数，无法购买"];
        return;
    }
    
    self.jsonTopKey = @"data";
    NSMutableDictionary* params = [@{@"itemId":itemId,@"userId":userId,@"addressId":addressId,@"skuId":skuId,@"buyNum":buyNum,@"payPrice":payPrice} mutableCopy];
    if (activityId) {
        [params setObject:activityId forKey:@"activityId"];
    }
    if (voucherId) {
        [params setObject:voucherId forKey:@"voucherId"];
    }
    
    self.needLogin = YES;
    [self loadItemWithAPIName:@"order/createOrder.do" params:params version:nil];
}

@end
