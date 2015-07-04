//
//  ManWuHongBaoInfoDescriptionView.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuHongBaoInfoDescriptionView.h"
#import "ManWuHomeVoucherModel.h"

@implementation ManWuHongBaoInfoDescriptionView

-(void)setupView{
    [super setupView];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem *)descriptionModel{
    if (![descriptionModel isKindOfClass:[ManWuHomeVoucherModel class]]) {
        return;
    }
    ManWuHomeVoucherModel* voucherModel = (ManWuHomeVoucherModel*)descriptionModel;
    if (voucherModel.activityTime) {
        NSString* activityTime = [NSString stringWithFormat:@"使用时间："];
        [self.descriptionArray addObject:activityTime];
        [self.descriptionArray addObject:voucherModel.activityTime];
    }
    if (voucherModel.activityRule) {
        NSString* activityRule = [NSString stringWithFormat:@"活动规则："];
        [self.descriptionArray addObject:activityRule];
        [self.descriptionArray addObject:voucherModel.activityRule];
    }
    if (voucherModel.useRange) {
        NSString* useRange = [NSString stringWithFormat:@"红包使用范围："];
        [self.descriptionArray addObject:useRange];
        [self.descriptionArray addObject:voucherModel.useRange];
    }
    [self reloadData];
}

@end
