//
//  ManWuDiscoverModel.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/25.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuDiscoverModel.h"

@implementation ManWuDiscoverModel

+(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"id":@"cid",@"childList":@"leafCategoryList"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
