//
//  TBDetailSkuModel.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"
#import "TBDetailSkuPropsModel.h"
#import "TBDetailSKUPriceAndQuanitiyModel.h"

@interface TBDetailSkuModel : WeAppComponentBaseItem

//ppath 和 skuid 的map
@property (nonatomic, strong) NSDictionary *ppathIdmap;


//宝贝SKU对应的宝贝属性列表
@property (nonatomic, strong) NSArray<TBDetailSkuPropsModel> *skuProps;

//sku对应的价格，库存,key 是skuid
@property (nonatomic, strong) NSDictionary<TBDetailSKUPriceAndQuanitiyModel> *skus;

@property (nonatomic, copy)   NSString *skuTitle;

@end
