//
//  ManWuAddressService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/26.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressService.h"

@implementation ManWuAddressService

-(void)loadAddressList{
    NSDictionary* params = @{@"userId":[KSAuthenticationCenter userId]?:@""};
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuAddressInfoModel class];
    self.needLogin = YES;
    [self loadDataListWithAPIName:@"address/fetchAddresses.do" params:params version:nil];
}

-(void)loadDefaultAddress{
    NSDictionary* params = @{@"userId":[KSAuthenticationCenter userId]?:@""};
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuAddressInfoModel class];
    self.needLogin = YES;
    [self loadItemWithAPIName:@"address/fetchDefaultAddress.do" params:params version:nil];
}

@end
