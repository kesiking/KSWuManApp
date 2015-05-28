//
//  ManWuCommodityListSortAndFiltForDiscountView.h
//  basicFoundation
//
//  Created by 逸行 on 15-5-6.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityListView.h"

@interface ManWuCommodityListSortAndFiltForDiscountView : ManWuCommodityListView

-(void)setDescriptionModel:(WeAppComponentBaseItem*)descriptionModel;

-(void)setActIdKey:(NSString*)actIdKey;

-(void)loadDataWithParams:(NSDictionary*)params;

@end
