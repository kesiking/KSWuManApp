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
    self.backgroundColor = [UIColor whiteColor];
    [self.titleLabel setHidden:YES];
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

- (CSLinearLayoutItemPadding)getLayoutPaddingWithIndex:(NSUInteger)index description:(NSString*)description{
    if (index % 2 == 0) {
        return CSLinearLayoutMakePadding(20, 15, 0, 0);
    }
    return CSLinearLayoutMakePadding(10, 15, 0, 0);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = [super sizeThatFits:size];;
    
    if ([self.descriptionArray count] > 0) {
        /*Bug,会以中点，上下缩的，不能直接设置Bound*/
        newSize = CGSizeMake(newSize.width, newSize.height + 25);
    }
    
    return newSize;
}

@end
