//
//  KSManWuHomeService.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-21.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSManWuHomeService.h"

#define advertisement_key_name @"adlist"
#define advertisement_api_name @"add"

@implementation KSManWuHomeService

-(void)getBannerAdvertisement{
    self.itemClass = [WeAppComponentBaseItem class];
    self.jsonTopKey = advertisement_key_name;
    [self loadDataListWithAPIName:advertisement_api_name params:nil version:nil];
}

@end
