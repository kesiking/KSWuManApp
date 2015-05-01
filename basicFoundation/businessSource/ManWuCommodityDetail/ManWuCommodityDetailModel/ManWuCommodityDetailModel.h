//
//  ManWuCommodityDetailModel.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"
#import "TBDetailSKUModelAndService.h"

@interface ManWuCommodityDetailModel : WeAppComponentBaseItem

@property (nonatomic, strong) TBDetailSKUModelAndService *skuDetailModel;

@property (nonatomic, strong) NSString                   *skuTitle;

@end
