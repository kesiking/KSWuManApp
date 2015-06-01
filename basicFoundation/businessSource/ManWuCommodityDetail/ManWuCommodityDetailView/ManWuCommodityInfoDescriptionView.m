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
        if (detailModel.size && [detailModel.size isKindOfClass:[NSArray class]]) {
            NSMutableString* string = [NSMutableString string];
            [string appendString:@"尺寸："];
            NSUInteger count = [detailModel.size count];
            for (NSString* sizeString in detailModel.size) {
                if (![sizeString isKindOfClass:[NSString class]]) {
                    continue;
                }
                [string appendString:sizeString];
                NSUInteger index = [detailModel.size indexOfObject:sizeString];
                if (index < count - 1) {
                    [string appendString:@"、"];
                }
            }
            [self.descriptionArray addObject:string];
        }
        if (detailModel.color && [detailModel.color isKindOfClass:[NSArray class]]) {
            NSMutableString* string = [NSMutableString string];
            [string appendString:@"颜色："];
            NSUInteger count = [detailModel.color count];
            for (NSString* sizeString in detailModel.color) {
                if (![sizeString isKindOfClass:[NSString class]]) {
                    continue;
                }
                [string appendString:sizeString];
                NSUInteger index = [detailModel.color indexOfObject:sizeString];
                if (index < count - 1) {
                    [string appendString:@"、"];
                }
            }
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
