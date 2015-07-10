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
    NSDictionary* params = @{@"id":safeString(addressId),@"userId":safeString(userId),@"recvName":safeString(recvName),@"phoneNum":safeString(phoneNum),@"address":safeString(address)/*[safeString(address) URLEncodedString]*/,@"defaultAddress":defaultAddress?@"true":@"false"};
    self.jsonTopKey = @"data";
    self.needLogin = YES;
    [self loadItemWithAPIName:@"address/modifyAddress.do" params:params version:nil];
}

-(void)deleteAddressInfoWithAddressId:(NSString *)addressId{
    if (addressId == nil) {
        return;
    }
    NSDictionary* params = @{@"id":safeString(addressId)};
    self.jsonTopKey = @"data";
    self.needLogin = YES;
    [self loadItemWithAPIName:@"address/deleteAddress.do" params:params version:nil];
}

-(void)addAddressInfoWithAddressId:(NSString *)addressId userId:(NSString *)userId recvName:(NSString *)recvName phoneNum:(NSString *)phoneNum address:(NSString *)address defaultAddress:(BOOL)defaultAddress{
    NSDictionary* params = @{@"id":safeString(addressId),@"userId":safeString(userId),@"recvName":safeString(recvName),@"phoneNum":safeString(phoneNum),@"address":safeString(address)/*[safeString(address) URLEncodedString]*/,@"defaultAddress":defaultAddress?@"true":@"false"};
    self.jsonTopKey = @"data";
    self.needLogin = YES;
    [self loadItemWithAPIName:@"address/addAddress.do" params:params version:nil];
}

@end
