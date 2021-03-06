//
//  ManWuCommodityDetailModel.h
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"
#import "TBDetailSKUModelAndService.h"
#import "ManWuCommoditySKUDetailModel.h"
#import "ManWuCommoditySKUModel.h"
#import "ManWuTradeDetailSKUService.h"

@interface ManWuCommodityDetailModel : WeAppComponentBaseItem

@property (nonatomic, strong) TBDetailSKUModelAndService *skuDetailModel;

@property (nonatomic, strong) NSString                   *skuTitle;

//ppath 和 skuid 的map
@property (nonatomic, strong) NSDictionary *ppathIdmap;

@property (nonatomic, strong) NSDictionary<ManWuCommoditySKUDetailModel>*               skuMap;

@property (nonatomic, strong) ManWuTradeDetailSKUService *skuService;

@property (nonatomic, strong) NSArray*                    skuOrder;
@property (nonatomic, strong) NSDictionary*               skuContent;
@property (nonatomic, strong) NSMutableArray*             skuArray;

@property (nonatomic, strong) NSDictionary*               featureMap;
@property (nonatomic, strong) NSArray*                    featureList;

@property (nonatomic, strong) NSString*                   itemId;
@property (nonatomic, strong) NSString*                   title;
@property (nonatomic, strong) NSString*                   img;
@property (nonatomic, strong) NSArray *                   otherImg;
@property (nonatomic, strong) NSMutableArray *            totleImgs;
@property (nonatomic, strong) NSNumber*                   price;
@property (nonatomic, strong) NSNumber*                   sale;
@property (nonatomic, strong) NSString*                   url;
@property (nonatomic, strong) NSNumber*                   cid;
@property (nonatomic, strong) NSString*                   discount;
@property (nonatomic, strong) NSString*                   addTime;
@property (nonatomic, strong) NSString*                   endTime;
@property (nonatomic, strong) NSString*                   isOn;
@property (nonatomic, strong) NSString*                   like;
@property (nonatomic, strong) NSNumber*                   love;
@property (nonatomic, strong) NSNumber*                   loved;
@property (nonatomic, strong) NSNumber*                   collected;
@property (nonatomic, strong) NSNumber*                   quantity;
@property (nonatomic, strong) NSString*                   brand;
@property (nonatomic, strong) NSString*                   fengge;
@property (nonatomic, strong) NSString*                   metarial;
@property (nonatomic, strong) NSNumber*                   status;
@property (nonatomic, strong) NSArray*                    size;
@property (nonatomic, strong) NSString*                   info;
@property (nonatomic, strong) NSArray*                    color;

@property (nonatomic, strong) NSNumber*                   activityId;
@property (nonatomic, strong) NSNumber*                   activityTypeId;
@property (nonatomic, strong) NSNumber*                   activityPrice;
@property (nonatomic, strong) NSNumber*                   activityDiscount;
@property (nonatomic, strong) NSNumber*                   activityBuyLimit;

@end
