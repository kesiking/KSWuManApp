//
//  ManWuCommodityDetailModel.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-28.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuCommodityDetailModel.h"

@implementation ManWuCommodityDetailModel

-(void)setFromDictionary:(NSDictionary *)dict{
    [super setFromDictionary:dict];
    self.skuArray = [NSMutableArray array];
//    if (self.skuOrder == nil) {
//        self.skuOrder = [self.skuContent allKeys];
//    }
    if (self.skuContent && self.skuOrder) {
        for (NSString* key in self.skuOrder) {
            if (![key isKindOfClass:[NSString class]]) {
                continue;
            }
            NSArray* propArray = [self.skuContent objectForKey:key];
            if (![propArray isKindOfClass:[NSArray class]]) {
                continue;
            }
            [self setupSKUArray:propArray withPropName:key];
        }
    }
    
    if ([self.skuArray count] > 0 && self.ppathIdmap == nil) {
        NSMutableDictionary* pathIdMapTemp = [[NSMutableDictionary alloc] init];
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (NSUInteger index = 0; index < [self.skuArray count]; index++) {
            NSMutableArray* skuPropAndValueArray = [[NSMutableArray alloc] init];
            ManWuCommoditySKUModel* skuProp = [self.skuArray objectAtIndex:index];
            NSArray *values = skuProp.values;
            for (TBDetailSkuPropsValuesModel *valueModel in values) {
                NSString* propIdAndValueId = [NSString stringWithFormat:@"%@",valueModel.valueId];
                [skuPropAndValueArray addObject:propIdAndValueId];
            }
            [array addObject:skuPropAndValueArray];
        }
        
        [self getPathIdRecur:array AtIndex:0 pathId:nil pathIdMap:pathIdMapTemp];
        self.ppathIdmap = pathIdMapTemp;
    }
    self.skuService = [[ManWuTradeDetailSKUService alloc] initWithDetailResult:self];
}

-(void)setupSKUArray:(NSArray*)skuProps withPropName:(NSString*)propName{
    ManWuCommoditySKUModel* skuSizeModel = [ManWuCommoditySKUModel new];
    skuSizeModel.propName = propName;
    skuSizeModel.propId = [NSString stringWithFormat:@"%lu",(unsigned long)[skuSizeModel hash]];
    skuSizeModel.values = [NSMutableArray array];
    NSUInteger count = [skuProps count];
    for (NSUInteger index = 0; index < count; index++) {
        TBDetailSkuPropsValuesModel* skuPropValueModel = [TBDetailSkuPropsValuesModel new];
        skuPropValueModel.valueId = [skuProps objectAtIndex:index];
        skuPropValueModel.name = [skuProps objectAtIndex:index];
        [skuSizeModel.values addObject:skuPropValueModel];
    }
    [self.skuArray addObject:skuSizeModel];
}

-(void)getPathIdRecur:(NSArray*)array AtIndex:(NSUInteger)index pathId:(NSString*)pathId pathIdMap:(NSMutableDictionary*)pathIdMap{
    @autoreleasepool {
        if (pathId == nil) {
            pathId = [NSString string];
        }
        if (pathIdMap == nil) {
            pathIdMap = [[NSMutableDictionary alloc] init];
        }
        NSUInteger indexRecur = index;
        if ([array count] <= indexRecur) {
            return;
        }
        NSArray *skuPropAndValueArray = [array objectAtIndex:indexRecur];
        for (NSUInteger j = 0; j < [skuPropAndValueArray count]; j++) {
            NSString* pathIdFromSku = [skuPropAndValueArray objectAtIndex:j];
            NSString* pathIdTmp = [pathId stringByAppendingString:pathIdFromSku];
            if (indexRecur < [array count] - 1) {
                pathIdTmp = [pathIdTmp stringByAppendingString:separatorForPidAndVid];
                [self getPathIdRecur:array AtIndex:indexRecur + 1 pathId:pathIdTmp pathIdMap:pathIdMap];
            }else{
                if (pathIdTmp) {
                    [pathIdMap setObject:pathIdTmp forKey:pathIdTmp];
                }
            }
        }
    }
}

+(TBJSONModelKeyMapper*)modelKeyMapper{
    NSDictionary* dict = @{@"id":@"itemId"};
    return [[TBJSONModelKeyMapper alloc] initWithDictionary:dict];
}

@end
