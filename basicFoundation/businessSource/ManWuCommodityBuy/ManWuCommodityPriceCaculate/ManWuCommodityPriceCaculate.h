//
//  ManWuCommodityPriceCaculate.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManWuCommodityDetailModel.h"

@interface ManWuCommodityPriceCaculate : NSObject

+ (NSString*)getStringWithNSNumber:(NSNumber*)number FractionDigits:(NSUInteger)fractionDigits;

- (void)setObject:(id)object dict:(NSDictionary*)dict;

- (float)getTruePriceWithVoucherPrice:(float)voucherPrice;

- (NSNumber*)getCommodityQuantity;

- (NSNumber*)getCommodityQuantityWithSkuModel:(ManWuCommoditySKUDetailModel*)skuModel;

- (NSNumber*)getCommodityPrice;

- (NSNumber*)getCommodityPriceWithSkuModel:(ManWuCommoditySKUDetailModel*)skuModel;

- (NSNumber*)getCommodityCount;

- (NSString*)getCommodityDiscount;

@end
