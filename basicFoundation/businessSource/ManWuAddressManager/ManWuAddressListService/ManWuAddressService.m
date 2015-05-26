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
    NSDictionary* params = @{@"userId":@"5"};
    self.jsonTopKey = @"data";
    self.itemClass = [ManWuAddressInfoModel class];
    [self loadDataListWithAPIName:@"user/fetchAddresses.do" params:params version:nil];
}

@end
