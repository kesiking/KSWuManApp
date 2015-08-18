//
//  ManWuHomeAdvertisementModel.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/8/18.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHomeAdvertisementModel.h"

@implementation ManWuHomeAdvertisementModel

+(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"id":@"advertisementId"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
