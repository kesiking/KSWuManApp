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
        
        if (detailModel.featureList) {
            for (NSDictionary* feature in detailModel.featureList) {
                if (![feature isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                NSString* key = [feature objectForKey:@"key"];
                id value = [feature objectForKey:@"value"];
                if (value == nil
                    || ![value isKindOfClass:[NSString class]]) {
                    continue;
                }
                NSString* string = [NSString stringWithFormat:@"%@：%@",key,value];
                [self.descriptionArray addObject:string];
            }
        }
        /*
        if (detailModel.featureMap) {
            for (NSString* key in [detailModel.featureMap allKeys]) {
                if (![key isKindOfClass:[NSString class]]) {
                    continue;
                }
                id value = [detailModel.featureMap objectForKey:key];
                if (value == nil
                    || ![value isKindOfClass:[NSString class]]) {
                    continue;
                }
                NSString* string = [NSString stringWithFormat:@"%@：%@",key,value];
                [self.descriptionArray addObject:string];
            }
        }
        if (detailModel.brand) {
            NSString* string = [NSString stringWithFormat:@"品牌:%@",detailModel.brand];
            [self.descriptionArray addObject:string];
        }
        if (detailModel.metarial) {
            NSString* string = [NSString stringWithFormat:@"材料:%@",detailModel.metarial];
            [self.descriptionArray addObject:string];
        }
        if (detailModel.fengge) {
            NSString* string = [NSString stringWithFormat:@"风格:%@",detailModel.fengge];
            [self.descriptionArray addObject:string];
        }
         */
        if (detailModel.skuContent) {
            @autoreleasepool {
                NSArray* arrayKeys = detailModel.skuOrder;
                if (arrayKeys == nil) {
                    arrayKeys = [detailModel.skuContent allKeys];
                }
                for (NSString* key in arrayKeys) {
                    if (![key isKindOfClass:[NSString class]]) {
                        continue;
                    }
                    NSArray* propArray = [detailModel.skuContent objectForKey:key];
                    if (![propArray isKindOfClass:[NSArray class]]) {
                        continue;
                    }
                    
                    NSMutableString* string = [NSMutableString string];
                    
                    [string appendFormat:@"%@：",key];
                    
                    NSUInteger count = [propArray count];
                    for (NSString* sizeString in propArray) {
                        if (![sizeString isKindOfClass:[NSString class]]) {
                            continue;
                        }
                        [string appendString:sizeString];
                        NSUInteger index = [propArray indexOfObject:sizeString];
                        if (index < count - 1) {
                            [string appendString:@"、"];
                        }
                    }
                    [self.descriptionArray addObject:string];
                }
            }
        }
    }
    [self reloadData];
}

@end
