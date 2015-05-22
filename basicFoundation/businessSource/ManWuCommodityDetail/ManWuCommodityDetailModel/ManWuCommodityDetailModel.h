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

@property (nonatomic, strong) NSString*                   itemId;
@property (nonatomic, strong) NSString*                   title;
@property (nonatomic, strong) NSString*                   img;
@property (nonatomic, strong) NSString*                   price;
@property (nonatomic, strong) NSString*                   sale;
@property (nonatomic, strong) NSString*                   url;
@property (nonatomic, strong) NSString*                   cid;
@property (nonatomic, strong) NSString*                   discount;
@property (nonatomic, strong) NSString*                   addTime;
@property (nonatomic, strong) NSString*                   endTime;
@property (nonatomic, strong) NSString*                   isOn;
@property (nonatomic, strong) NSString*                   like;
@property (nonatomic, strong) NSString*                   brand;
@property (nonatomic, strong) NSString*                   metarial;
@property (nonatomic, strong) NSString*                   size;
@property (nonatomic, strong) NSString*                   info;
@property (nonatomic, strong) NSString*                   color;

@end
