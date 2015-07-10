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
        || [WeAppUtils isEmpty:itemId]
        || [WeAppUtils isEmpty:buyNum]
        || [WeAppUtils isEmpty:payPrice]) {
        [WeAppToast toast:@"缺少必要参数，无法购买"];
        return;
    }
    
    self.jsonTopKey = @"data";
    NSMutableDictionary* params = [@{@"itemId":itemId,@"userId":userId,@"addressId":addressId,@"buyNum":buyNum,@"payPrice":payPrice} mutableCopy];
    if (skuId) {
        [params setObject:skuId forKey:@"skuId"];
    }else{
        [params setObject:@0 forKey:@"skuId"];
    }
    if (activityId) {
        [params setObject:activityId forKey:@"activityId"];
    }
    if (voucherId) {
        [params setObject:voucherId forKey:@"voucherId"];
    }
    
    self.needLogin = YES;
    self.jsonTopKey = @"data";
    [self loadNumberValueWithAPIName:@"order/createOrder.do" params:params version:nil];
}

-(void)loadOrderItemWithOrderId:(NSNumber*)orderId{
    if ([WeAppUtils isEmpty:orderId]) {
        [WeAppToast toast:@"缺少必要参数，无法购买"];
        return;
    }
    self.needLogin = YES;
    self.jsonTopKey = @"data";
    self.itemClass = [KSOrderModel class];
    [self loadItemWithAPIName:@"order/orderDetail.do" params:@{@"orderId":orderId} version:nil];
}

@end
