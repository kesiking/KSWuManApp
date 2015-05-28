//
//  ManWuAddressEditService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressEditService.h"

#define safeString(x) (x?:@"")

@implementation ManWuAddressEditService

-(void)editAddressInfoWithAddressId:(NSString *)addressId userId:(NSString *)userId recvName:(NSString *)recvName phoneNum:(NSString *)phoneNum address:(NSString *)address defaultAddress:(BOOL)defaultAddress{
    if (addressId == nil) {
        [self addAddressInfoWithAddressId:addressId userId:userId recvName:recvName phoneNum:phoneNum address:address defaultAddress:defaultAddress];
        return;
    }
    NSDictionary* params = @{@"addressId":safeString(addressId),@"userId":safeString(userId),@"recvName":safeString(recvName),@"phoneNum":safeString(phoneNum),@"address":safeString(address),@"defaultAddress":[NSNumber numberWithBool:defaultAddress]};
    self.jsonTopKey = @"data";
    [self loadItemWithAPIName:@"user/modifyAddress.do" params:params version:nil];
}

-(void)addAddressInfoWithAddressId:(NSString *)addressId userId:(NSString *)userId recvName:(NSString *)recvName phoneNum:(NSString *)phoneNum address:(NSString *)address defaultAddress:(BOOL)defaultAddress{
    NSDictionary* params = @{@"addressId":safeString(addressId),@"userId":safeString(userId),@"recvName":safeString(recvName),@"phoneNum":safeString(phoneNum),@"address":safeString(address),@"defaultAddress":[NSNumber numberWithBool:defaultAddress]};
    self.jsonTopKey = @"data";
    [self loadItemWithAPIName:@"address/addAddress.do" params:params version:nil];
}

@end
