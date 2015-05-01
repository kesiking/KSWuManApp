//
//  TBTradeDetailSKUService.h
//  TBTradeSDK
//
//  Created by neo on 14-1-23.
//  Copyright (c) 2014年 christ.yuj. All rights reserved.
//

@class TBDetailSKUModelAndService;

#import <Foundation/Foundation.h>
#import "TBDetailSKUInfo.h"

@protocol TBDetailPidVidPair <NSObject>
@end
@interface TBDetailPidVidPair : NSObject

@property (nonatomic ,strong) NSString * pid;
@property (nonatomic ,strong) NSString * vid;

- (id)initWithPid:(NSString *)pid vid:(NSString *)vid;
- (id)initWithPidvid:(NSString *)pidvid; //分号隔开

@end

@interface TBTradeDetailSKUService : NSObject

- (id)initWithDetailResult:(TBDetailSKUModelAndService *)tbDetailModel;
- (void)resetDetailResult:(TBDetailSKUModelAndService *)tbDetailModel;
- (BOOL)hasSKU;

- (TBDetailSKUInfo *)skuSelected:(TBDetailPidVidPair *)pair;
- (TBDetailSKUInfo *)skuUnSelected:(TBDetailPidVidPair *)pair;

- (TBDetailSKUInfo *)cascadeSkuSelected:(NSArray<TBDetailPidVidPair> *)pvPair;

- (TBDetailSKUInfo *)serviceSelected:(NSString *)serviceId UniqId:(NSString *)uniqid;
- (TBDetailSKUInfo *)serviceSelected:(NSString *)serviceId;

- (TBDetailSKUInfo *)serviceUnSelected:(NSString *)serviceId UniqId:(NSString *)uniqid;
- (TBDetailSKUInfo *)serviceUnSelected:(NSString *)serviceId;

- (TBDetailSKUInfo *)currentSKUInfo;

- (TBDetailSKUInfo *)skuInitWithSkuId:(NSString *) skuId;

- (TBDetailSKUInfo *)removeSelects;

- (NSMutableDictionary *)pidvidMap;//用户已选择的pv对
- (NSArray *)casCadePidvids;//用户已选择的级联pv对

- (NSString *)getSelectServerIds;

- (NSArray *)selectServices;//当前已选择的服务列表 serviceId|uniqId的形式


@end

