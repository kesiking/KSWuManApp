//
//  ManWuCommodityPriceCaculate.m
//  basicFoundation
//
//  Created by 孟希羲 on 15/7/23.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityPriceCaculate.h"
#import "ManWuCommodityDetailModel.h"

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
    return quantity;
}

- (NSNumber*)getCommodityPrice{
    return [self.dict objectForKey:@"skuPrice"]?:(self.detailModel.sale?:self.detailModel.price);
}

- (NSNumber*)getCommodityCount{
    return [self.dict objectForKey:@"buyNumber"]?:@1;
}

- (NSString*)getCommodityDiscount{
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
    
    return (float)(price * count - voucherPrice);
}

@end
