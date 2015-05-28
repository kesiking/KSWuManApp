//
//  ManWuCommoditySKUDetailModel.h
//  basicFoundation
//
//  Created by 孟希羲 on 15/5/28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "WeAppComponentBaseItem.h"

@protocol ManWuCommoditySKUDetailModel <NSObject>

@end

@interface ManWuCommoditySKUDetailModel : WeAppComponentBaseItem

@property (nonatomic, strong) NSString*             addTime;
@property (nonatomic, strong) NSString*             alias;
@property (nonatomic, strong) NSNumber*             cid;
@property (nonatomic, strong) NSString*             color;
@property (nonatomic, strong) NSString*             dataOwner;
@property (nonatomic, strong) NSString*             feature;
@property (nonatomic, strong) NSNumber*             itemId;
@property (nonatomic, strong) NSString*             nodeId;
@property (nonatomic, strong) NSString*             operTime;
@property (nonatomic, strong) NSNumber*             price;
@property (nonatomic, strong) NSNumber*             quantity;
@property (nonatomic, strong) NSString*             sellerBianma;
@property (nonatomic, strong) NSString*             size;
@property (nonatomic, strong) NSNumber*             status;

@end
