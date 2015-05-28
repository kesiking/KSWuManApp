//
//  ManWuCommodityActivityService.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityActivityService.h"
#import "ManWuHomeActivityInfoModel.h"

@implementation ManWuCommodityActivityService

-(void)loadCommodityActivityDataWithTypeId:(NSString*)typeId{
    if (typeId == nil) {
        typeId = @"1";
    }
    self.itemClass = [ManWuHomeActivityInfoModel class];
    self.jsonTopKey = @"data";
    [self loadItemWithAPIName:@"activity/getActivity.do" params:@{@"typeId":typeId} version:nil];
}

@end
