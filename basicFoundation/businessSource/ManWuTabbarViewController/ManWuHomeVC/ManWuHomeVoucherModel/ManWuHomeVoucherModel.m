//
//  ManWuHomeVoucherModel.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/6/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeVoucherModel.h"

@implementation ManWuHomeVoucherModel

+(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"id":@"voucherId"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
