//
//  ManWuCommodityDetailModel.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityDetailModel

-(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"itemId":@"id"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
