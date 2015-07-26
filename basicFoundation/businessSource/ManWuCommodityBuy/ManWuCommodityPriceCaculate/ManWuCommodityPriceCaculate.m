//
//  ManWuCommodityPriceCaculate.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityPriceCaculate.h"

#define USE_ACTIVITY_DISCOUNT_IN_PRICE

@interface ManWuCommodityPriceCaculate()

@property (nonatomic, strong)   ManWuCommodityDetailModel* detailModel;
@property (nonatomic, strong)   NSDictionary*              dict;

@end

@implementation ManWuCommodityPriceCaculate

- (void)setObject:(id)object dict:(NSDictionary*)dict{
    if (![object isKindOfClass:[ManWuCommodityDetailModel class]]) {
        return;
    }
    self.detailModel = (ManWuCommodityDetailModel*)object;
    self.dict = dict;
}

- (NSNumber*)getCommodityQuantity{
    NSString* selectSkuPpathId = [self.dict objectForKey:@"selectSkuPpathId"];
    NSNumber* quantity = self.detailModel.quantity;
    if (selectSkuPpathId) {
        NSNumber* quantityNumber = ((ManWuCommoditySKUDetailModel*)[self.detailModel.skuMap objectForKey:selectSkuPpathId]).quantity;
        if (quantityNumber) {
            quantity = quantityNumber;
        }
    }
    NSNumber* activityQuantity = self.detailModel.activityBuyLimit;
    if (activityQuantity) {
        return [activityQuantity floatValue] > [quantity floatValue] ? quantity : activityQuantity;
    }
    return quantity;
}

- (NSNumber*)getCommodityQuantityWithSkuModel:(ManWuCommoditySKUDetailModel*)skuModel{
    if (self.detailModel.activityBuyLimit) {
        return [self.detailModel.activityBuyLimit floatValue] > [skuModel.quantity floatValue] ? skuModel.quantity : self.detailModel.activityBuyLimit;
    }
    return skuModel.quantity;
}

- (NSNumber*)getCommodityPrice{
    NSNumber* price = self.detailModel.activityPrice;
    if (price == nil) {
        price = self.detailModel.sale?:self.detailModel.price;
#ifdef USE_ACTIVITY_DISCOUNT_IN_PRICE
        if (self.detailModel.activityDiscount && self.detailModel.activityPrice == nil) {
             price = [NSNumber numberWithFloat:[price floatValue] * [self.detailModel.activityDiscount floatValue]];
        }
#endif
    }
    return [self.dict objectForKey:@"skuPrice"]?:price;
}

- (NSNumber*)getCommodityPriceWithSkuModel:(ManWuCommoditySKUDetailModel*)skuModel{
#ifdef USE_ACTIVITY_DISCOUNT_IN_PRICE
    if (self.detailModel.activityDiscount && self.detailModel.activityPrice == nil) {
        NSNumber* price = [NSNumber numberWithFloat:[skuModel.price floatValue] * [self.detailModel.activityDiscount floatValue]];
        return price;
    }
#endif
    return self.detailModel.activityPrice?:skuModel.price;
}

- (NSNumber*)getCommodityCount{
    return [self.dict objectForKey:@"buyNumber"]?:@1;
}

- (NSString*)getCommodityDiscount{
    if (self.detailModel.activityDiscount && self.detailModel.activityPrice == nil) {
        return [NSString stringWithFormat:@"%@",self.detailModel.activityDiscount];
    }
    CGFloat discount = 0;
    NSNumber* salePrice = [self getCommodityPrice];

    NSString* discountStr = [NSString stringWithFormat:@"%@",self.detailModel.discount];
    if (self.detailModel.price && [self.detailModel.price floatValue] != 0) {
        discount = [salePrice floatValue] / [self.detailModel.price floatValue];
    }
    if (discount > 0 && discount <= 1) {
        discountStr = [NSString stringWithFormat:@"%.1f折",discount * 10];
    }
    return discountStr;
}

- (float)getTruePriceWithVoucherPrice:(float)voucherPrice{
    NSUInteger count = [[self getCommodityCount] unsignedIntegerValue];
    float price = [[self getCommodityPrice] floatValue];
#ifndef USE_ACTIVITY_DISCOUNT_IN_PRICE
    if (self.detailModel.activityDiscount && self.detailModel.activityPrice == nil) {
        price = price * [self.detailModel.activityDiscount floatValue];
    }
#endif
    return (float)(price * count - voucherPrice);
}

@end
