//
//  ManWuTradeDetailSKUService.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBDetailSKUInfo.h"

@class ManWuCommodityDetailModel,TBDetailPidVidPair;

@interface ManWuTradeDetailSKUService : NSObject

- (id)initWithDetailResult:(ManWuCommodityDetailModel *)tbDetailModel;
- (void)resetDetailResult:(ManWuCommodityDetailModel *)tbDetailModel;
- (BOOL)hasSKU;

- (TBDetailSKUInfo *)skuSelected:(TBDetailPidVidPair *)pair;
- (TBDetailSKUInfo *)skuUnSelected:(TBDetailPidVidPair *)pair;

- (TBDetailSKUInfo *)currentSKUInfo;

- (NSMutableDictionary *)pidvidMap;//用户已选择的pv对

@end
