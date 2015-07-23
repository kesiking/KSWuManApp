//
//  ManWuCommodityPriceCaculate.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManWuCommodityPriceCaculate : NSObject

- (void)setObject:(id)object dict:(NSDictionary*)dict;

- (float)getTruePriceWithVoucherPrice:(float)voucherPrice;

- (NSNumber*)getCommodityQuantity;

- (NSNumber*)getCommodityPrice;

- (NSNumber*)getCommodityPriceWithSkuPrice:(NSNumber*)skuPrice;

- (NSNumber*)getCommodityCount;

- (NSString*)getCommodityDiscount;

@end
