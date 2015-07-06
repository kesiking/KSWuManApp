//
//  ManWuVoucherService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuVoucherService.h"
#import "ManWuVoucherModel.h"

@implementation ManWuVoucherService

-(void)loadVoucherWithItemId:(NSString*)itemId
                      buyNum:(NSNumber*)buyNum{
    if ([WeAppUtils isEmpty:itemId]
        || [WeAppUtils isEmpty:buyNum]) {
        return;
    }
    
    self.jsonTopKey = @"data";
    NSDictionary* params = @{@"itemId":itemId,@"buyNum":buyNum};
    
    [self loadItemWithAPIName:@"voucher/getItemVouchers.do" params:params version:nil];
}

-(void)fetchVoucherWithCidId:(NSNumber*)cidId
                      userId:(NSString*)userId
                    payPrice:(NSNumber*)payPrice{
    if ([WeAppUtils isEmpty:cidId]
        || [WeAppUtils isEmpty:userId]
        || [WeAppUtils isEmpty:payPrice]) {
        return;
    }
    
    self.jsonTopKey = @"data";
    NSDictionary* params = @{@"catId":cidId,@"userId":userId,@"payPrice":payPrice};
    
    self.itemClass = [ManWuVoucherModel class];
    
    [self loadDataListWithAPIName:@"user/fetchVouchersForOrder.do" params:params version:nil];
}

@end
