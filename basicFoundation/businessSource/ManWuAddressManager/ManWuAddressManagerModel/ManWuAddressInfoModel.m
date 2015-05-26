//
//  ManWuAddressInfoModel.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-8.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressInfoModel.h"

@implementation ManWuAddressInfoModel

+(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"id":@"addressId"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}


@end
