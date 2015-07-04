//
//  KSRedPacketModel.m
//  basicFoundation
//
//  Created by 许学 on 15/7/1.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSRedPacketModel.h"

@implementation KSRedPacketModel

+(TBJSONModelKeyMapper*)modelKeyMapper
{
    NSDictionary* dict = @{@"id":@"redpacektId"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
