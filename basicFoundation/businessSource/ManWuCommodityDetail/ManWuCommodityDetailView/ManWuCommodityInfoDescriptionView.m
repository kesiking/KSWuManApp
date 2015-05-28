//
//  ManWuCommodityDescriptionView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-4.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityInfoDescriptionView.h"
#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityInfoDescriptionView

-(void)setupView{
    [super setupView];
    [self.titleLabel setText:@"商品详情"];
}

-(void)setDescriptionModel:(WeAppComponentBaseItem *)descriptionModel{
    /*
     for (NSUInteger index = 0; index < 5 ; index++) {
        NSString* string = [NSString stringWithFormat:@"测试发大水发的撒:%lu",(unsigned long)index];
        [self.descriptionArray addObject:string];
    }
     */
    if ([descriptionModel isKindOfClass:[ManWuCommodityDetailModel class]]) {
        ManWuCommodityDetailModel* detailModel = (ManWuCommodityDetailModel*)descriptionModel;
        if (detailModel.brand) {
            NSString* string = [NSString stringWithFormat:@"品牌:%@",detailModel.brand];
            [self.descriptionArray addObject:string];
        }
        if (detailModel.metarial) {
            NSString* string = [NSString stringWithFormat:@"材料:%@",detailModel.metarial];
            [self.descriptionArray addObject:string];
        }
        if (detailModel.size) {
            NSString* string = [NSString stringWithFormat:@"尺寸:%@",detailModel.size];
            [self.descriptionArray addObject:string];
        }
        if (detailModel.color) {
            NSString* string = [NSString stringWithFormat:@"颜色:%@",detailModel.color];
            [self.descriptionArray addObject:string];
        }
        if (detailModel.fengge) {
            NSString* string = [NSString stringWithFormat:@"风格:%@",detailModel.fengge];
            [self.descriptionArray addObject:string];
        }
    }
    [self reloadData];
}

@end
