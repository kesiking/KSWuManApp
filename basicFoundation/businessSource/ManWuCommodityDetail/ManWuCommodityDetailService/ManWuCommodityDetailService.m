//
//  ManWuCommodityDetailService.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDetailService.h"

@implementation ManWuCommodityDetailService

-(void)loadTest{
    self.jsonTopKey = @"data";
    [self loadNumberValueWithAPIName:@"user/queryCode.do" params:@{@"phonenum":@18626876833} version:nil];
}

-(void)loadLogin{
    self.jsonTopKey = @"data";
    [self loadItemWithAPIName:@"user/login.do" params:@{@"username":@"yongl",@"pwd":@123} version:nil];
}

@end
