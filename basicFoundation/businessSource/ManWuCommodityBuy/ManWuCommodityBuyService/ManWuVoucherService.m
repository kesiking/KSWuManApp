//
//  ManWuVoucherService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuVoucherService.h"

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

@end
