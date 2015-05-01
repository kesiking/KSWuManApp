//
//  TBDetailSKUInfo.h
//  TBTradeSDK
//
//  Created by neo on 14-1-23.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TBDetailPriceUnitsModel.h"

@interface TBDetailSKUInfo : NSObject

@property (nonatomic, strong) NSString                 *selectSkuId;
@property (nonatomic, assign) NSInteger                quantity;//sku 库存
@property (nonatomic, strong) NSString                 *quantityText;
@property (nonatomic, strong) NSArray<TBDetailPriceUnitsModel > *priceUnits;//sku价格
@property (nonatomic, strong) NSString                 *skuDisplayString;// sku文案
@property (nonatomic, strong) NSString                 *skuPopUpString;// sku浮层文案
@property (nonatomic, strong) NSString                 *skuCellString;// skucell文案
@property (nonatomic, strong) NSString                 * picUrl;//图片

//key:propId:valueId  value:true or false
@property (nonatomic, strong) NSDictionary             *enableMap;
@property (nonatomic, strong) NSArray                  *servieUnits;//TBDetailServiceUnit的列表的列表

@end
