//
//  ManWuVoucherModel.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/27.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuVoucherModel.h"

@implementation ManWuVoucherModel

+(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"id":@"voucherId",@"description":@"voucherDescription"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
