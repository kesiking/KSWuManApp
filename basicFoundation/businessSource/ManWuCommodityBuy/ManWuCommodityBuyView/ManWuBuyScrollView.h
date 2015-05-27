//
//  ManWuBuyScrollView.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-30.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "KSView.h"

@class ManWuCommodityDetailModel;

@interface ManWuBuyScrollView : KSView

@property (nonatomic, strong) ManWuCommodityDetailModel         *detailModel;
@property (nonatomic, strong) NSMutableDictionary               *dict;

- (void)setObject:(ManWuCommodityDetailModel *)object dict:(NSDictionary *)dict;

@end
