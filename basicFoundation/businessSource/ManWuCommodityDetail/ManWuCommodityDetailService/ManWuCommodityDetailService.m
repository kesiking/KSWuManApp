//
//  ManWuCommodityDetailService.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-29.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDetailService.h"

@implementation ManWuCommodityDetailService

-(void)loadCommodityDetailInfoWithItemId:(NSString*)itemId{
    if (itemId == nil) {
        [WeAppToast toast:@"宝贝ID为空"];
        return;
    }
    self.jsonTopKey = @"data";
    self.itemClass = NSClassFromString(@"ManWuCommodityDetailModel");
    NSDictionary* params = @{@"itemId":@1};
    
    [self loadItemWithAPIName:@"item/getItem.do" params:params version:nil];
}

-(void)loadTest{
    self.jsonTopKey = @"data";
    [self loadNumberValueWithAPIName:@"user/queryCode.do" params:@{@"phonenum":@18626876833} version:nil];
}

-(void)loadInvite{
    self.jsonTopKey = @"data";
    [self loadNumberValueWithAPIName:@"user/register.do" params:@{@"phonenum":@"18800113354",@"validatecode":@"188001",@"pwd": @"18800113354",@"code":@"113354" , @"username": @"dingdingdang"} version:nil];
}

-(void)loadLogin{
    self.jsonTopKey = @"data";
    [self loadItemWithAPIName:@"user/login.do" params:@{@"username":@"yongl",@"pwd":@123} version:nil];
}

@end
