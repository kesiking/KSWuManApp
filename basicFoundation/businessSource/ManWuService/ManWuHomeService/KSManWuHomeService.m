//
//  KSManWuHomeService.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSManWuHomeService.h"

#define advertisement_key_name @"data"
#define advertisement_api_name @"index/getVoucherActivities.do"

#define home_activity_key_name @"data"
#define home_activity_api_name @"index/getActs.do"

@implementation KSManWuHomeService

-(void)loadHomeActivityData{
    self.itemClass = [ManWuHomeActivityInfoModel class];
    self.jsonTopKey = home_activity_key_name;
    [self loadDataListWithAPIName:home_activity_api_name params:nil version:nil];
}

-(void)loadBannerVoucherData{
    self.itemClass = [ManWuHomeVoucherModel class];
    self.jsonTopKey = advertisement_key_name;
    [self loadDataListWithAPIName:advertisement_api_name params:nil version:nil];
}

@end
