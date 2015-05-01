//
//  TBDetailSKUPriceAndQuanitiyModel.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"
#import "TBDetailPriceUnitsModel.h"

@protocol TBDetailSKUPriceAndQuanitiyModel <NSObject>

@end

@interface TBDetailSKUPriceAndQuanitiyModel : WeAppComponentBaseItem

//sku 库存
@property (nonatomic, assign) NSInteger quantity;
//库存文案
@property (nonatomic, strong) NSString *quantityText;
//sku价格
@property (nonatomic, copy)   NSArray<TBDetailPriceUnitsModel> *priceUnits;

@end
