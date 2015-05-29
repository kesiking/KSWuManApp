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
    NSDictionary* dict = @{@"id":@"addressId",@"phone":@"phoneNum"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

-(void)setFromDictionary:(NSDictionary *)dict{
    [super setFromDictionary:dict];
    self.address = [self.address URLDecodedString];
}
@end
